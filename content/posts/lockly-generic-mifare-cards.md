---
title: "Using Generic MIFARE Cards with Lockly Smart Locks"
date: 2026-03-14
draft: false
tags: ["hardware", "security", "reverse-engineering"]
categories: ["Hardware Projects"]
description: "How to save 96% on Lockly RFID cards by using generic MIFARE Classic 1K cards with your own lock."
showToc: true
---

Lockly RFID locks use standard MIFARE Classic 1K cards (13.56 MHz), but ship with one sector key changed from the factory default. This causes generic cards to fail enrollment. Using a Proxmark3 on your own Lockly card, you can recover this key and write it to inexpensive generic cards in about 5 minutes, saving up to 96% on replacements.

**Important clarification:** This process does not clone an existing card or bypass your lock. It prepares a blank generic card so it can be enrolled through the Lockly Home app just like a new Lockly-branded card. You still go through the normal enrollment process; you're just not paying $8 per card to do it.

## A Note on Scope and Intent

This research was conducted entirely on personally owned equipment: a Lockly lock and Lockly-branded RFID cards purchased by the author. No systems were accessed without authorization, and no security vulnerabilities were discovered or exploited.

This article describes interoperability research. The goal is enabling standard, off-the-shelf cards to function with hardware you own. It does not compromise the physical security of the lock, and it does not enable any unauthorized access. The lock remains just as secure after this process as before.

Right-to-repair and interoperability exemptions under DMCA Section 1201(f) explicitly protect this type of research on devices you own.

## The Problem: Why Generic Cards Don't Work

Lockly's RFID-enabled smart locks (the Secure Plus, Secure Lux, Guard, and related models) support MIFARE Classic 1K cards for tap-to-unlock access. This guide was tested on the Lockly Secure Plus (Model PGD628FCMB). Other Lockly RFID models likely behave the same way, but have not been independently verified. Each lock ships with 3 branded cards, and official Lockly replacement packs run about $25 for 3 cards, roughly $8 each.

Generic MIFARE Classic 1K cards are widely available on Amazon for $0.30 to $0.50 each in bulk. Same underlying chip, fraction of the price.

The catch: purchase a pack of generic cards, try to enroll them through the Lockly Home app, and the lock silently rejects them. No error message, no feedback. They just don't enroll.

## Investigation: What Makes Lockly Cards Different?

### Initial Theories

Before reading the cards, a few explanations seemed plausible:

- Wrong chip variant: some cards use Fudan F08 clones that certain readers reject
- Wrong UID length: 7-byte vs. standard 4-byte UIDs
- Wrong frequency: 125 kHz cards accidentally purchased instead of 13.56 MHz

### Chip-Level Comparison

Using MIFARE Classic Tool on Android, we scanned both an official Lockly card and a generic Meikuler-brand MIFARE Classic 1K card. At the protocol level, they were identical:

| Field | Lockly Card | Generic Card |
|---|---|---|
| UID Length | 4-byte | 4-byte |
| ATQA | 0004 | 0004 |
| SAK | 08 | 08 |
| Tag Type | MIFARE Classic 1K, NXP | MIFARE Classic 1K, NXP |
| Memory | 1024 bytes, 16 sectors | 1024 bytes, 16 sectors |

The chip was not the issue. Both cards presented identically at the protocol level.

### The Key Difference: Sector 0

The difference showed up in the sector dump. When reading all sectors using default keys:

- **Generic card:** All 16 sectors readable. Every key was the factory default (`FFFFFFFFFFFF`).
- **Lockly card:** Sectors 1 through 15 were readable with default keys, but Sector 0 was completely unreadable. The default keys failed to authenticate.

Lockly had changed the cryptographic key on Sector 0 before shipping the card. Additionally, Block 63 (Sector 15's trailer) had a minor difference in its access condition byte.

### How MIFARE Key Authentication Works

MIFARE Classic 1K cards have 16 sectors, each protected by two 6-byte cryptographic keys (Key A and Key B). At the factory, all keys are set to `FFFFFFFFFFFF`. Card owners can change these keys to restrict access to individual sectors.

During enrollment, the Lockly lock attempts to authenticate to Sector 0 using its proprietary key. If authentication fails, enrollment is silently rejected. Any card still using the factory default key will fail this check.

> **In plain terms:** Lockly ships cards pre-configured with a non-default sector key. Generic cards don't have this key, so the lock won't enroll them. This is a deliberate configuration choice, not a security feature.

## Solution: Programming Generic Cards for Your Own Lock

### What You'll Need

- Proxmark3 (any variant: Easy, RDV4, or clone) with Iceman firmware
- One working Lockly RFID card from your lock's original set
- Generic MIFARE Classic 1K cards (Meikuler brand from Amazon works well)

### Step 1: Recover the Sector Key from Your Own Card

Run the Proxmark3's autopwn command against your Lockly card:

```
hf mf autopwn
```

Since Sectors 1 through 15 all use default keys, the tool uses a nested attack. It leverages the known keys to mathematically derive the unknown Sector 0 key. The whole process takes about 4 seconds.

Result from our test card:

- Sector 0 Key A: `FB5F52DEB87A`
- Sector 0 Key B: `FFFFFFFFFFFF` (unchanged default)
- All other sectors: factory defaults

> **Note:** Your key may differ from what's shown here. Lockly may use the same key across all cards, or values may vary by batch or product line. Always recover the key from your own card rather than using values published online.

### Step 2: Confirm the Sector Trailer Configuration

Read Sector 0's trailer block (Block 3) from your Lockly card before writing anything to a generic card:

- Key A: `FB5F52DEB87A` (or your recovered value)
- Access bits: `FF 07 80` (standard transport configuration)
- User byte: `69` (default)
- Key B: `FFFFFFFFFFFF` (default)

The only modification Lockly made was changing Key A on Sector 0. Everything else is at factory defaults.

### Step 3: Write the Key to a Generic Card

Place a generic card on the Proxmark3 antenna and write the recovered key into its Sector 0 trailer:

```
hf mf wrbl --blk 3 -k FFFFFFFFFFFF -d FB5F52DEB87AFF078069FFFFFFFFFFFF
```

This authenticates using the generic card's current default key, then writes your recovered Key A along with the standard access bits and default Key B. Also write the modified Sector 15 access bits to match the Lockly card:

```
hf mf wrbl --blk 63 -k FFFFFFFFFFFF -d FFFFFFFFFFFFFF0780BCFFFFFFFFFFFF
```

Total write time: under 2 seconds per card.

### Step 4: Enroll the Card

Present the programmed card to your lock through the Lockly Home app's standard card enrollment process. It will enroll normally, exactly like the original branded card would.

## Key Takeaways

- Lockly locks use standard MIFARE Classic 1K at 13.56 MHz (ISO 14443A). "MIFRED" in Lockly's marketing is just a branding term for standard MIFARE.
- The enrollment restriction is a single changed key on Sector 0. There is no encrypted data payload, signed token, or UID whitelist involved. It is a configuration choice, not a security mechanism.
- This process prepares a card for enrollment. It does not clone an existing enrolled card or grant access to any lock without going through the normal enrollment process.
- The economics are significant. Lockly charges about $8 per card; generics cost $0.30 to $0.50. A Proxmark3 is a one-time investment, and once you have the key, programming additional cards takes seconds each.
- This process does not weaken the security of your lock in any way.

## Security Context: What This Tells Us About MIFARE Classic

MIFARE Classic 1K is widely deployed but offers minimal cryptographic security against a determined attacker. The CRYPTO1 cipher it uses was publicly broken in 2008, and key recovery tools are freely available and well-documented.

This matters for two reasons.

First, Lockly's use of a single changed sector key as an enrollment gate provides no meaningful security advantage. An attacker wanting to clone a Lockly card could do so just as easily as a legitimate owner recovering their own key. The sector key was not protecting the lock from unauthorized access. It was preventing consumers from using less expensive cards.

Second, if you are evaluating the overall security of a Lockly lock: the RFID card is the weakest access method. Lockly's fingerprint reader, PIN codes, and app-based Bluetooth/WiFi access are all meaningfully more secure. Cards are convenient, but treat them accordingly.

---

> **Scope reminder:** This article is intended as consumer information for Lockly lock owners. It describes interoperability research conducted on personally owned equipment. It does not describe any security vulnerability in Lockly's products, and it does not enable unauthorized access to any lock or system.

---

*Tools used: Proxmark3 (Iceman firmware), MIFARE Classic Tool (Android), Linux Mint*

*Tested on: Lockly Secure Plus, Model PGD628FCMB. Other Lockly RFID-enabled models likely use the same approach, but have not been independently verified. Your results may vary.*
