---
title: "Your Hardware Team Doesn't Have a Skills Problem. It Has a Signal Problem."
date: 2026-03-14
draft: false
tags: ["leadership", "team-building", "hardware", "communication"]
categories: ["Engineering Leadership"]
series: ["Leadership Dispatches"]
description: "Most hardware teams that ship late, fight fires, and burn out their best people aren't underskilled. They're undersignaled. Here's what I mean."
cover:
  image: ""
  alt: ""
  relative: false
showToc: true
TocOpen: false
weight: 1
---

I've been called in to consult on a number of struggling hardware programs over the years. The client usually describes the same symptoms: schedule is blown, team is demoralized, fingers are pointing, and the most experienced engineer is starting to LinkedIn-lurk.

The instinct — especially from executives — is to diagnose this as a skills gap. Maybe we need a stronger lead. Maybe the PCB layout engineer isn't experienced enough. Maybe we should bring in a contractor.

Sometimes that's true. But more often, I find the team has exactly the skills the job requires. What they don't have is **signal**.

---

## What I Mean By Signal

In electronics, signal is information. A valid signal has the right amplitude, the right timing, and enough noise margin that the receiving circuit doesn't confuse a one for a zero. A weak or missing signal doesn't mean there's nothing happening in the system — it means the system can't make sense of what's happening.

Engineering teams work the same way.

When a team doesn't know the real priority order of competing tasks, that's a signal problem. When nobody knows whether the program is on track because the schedule hasn't been updated in six weeks, that's a signal problem. When the mechanical engineer doesn't know about the thermal budget change that electrical made last Tuesday, that's a signal problem.

The team might be individually brilliant. But if they're all operating on stale, incomplete, or ambiguous information, you will get the same output as an underskilled team. Late. Broken. Expensive.

---

## The Most Common Signal Failures I See

### 1. The Schedule Is a Fiction

Most hardware schedules I encounter are generated once, at the start of the program, and then used as a performance benchmark without ever being updated to reflect reality.

This is almost worse than no schedule at all. The team knows the schedule is wrong. Leadership *thinks* the schedule is right. Every status meeting becomes a performance of optimism, with engineers quietly absorbing slip after slip rather than surfacing it.

A hardware schedule that isn't updated at least weekly during active development isn't a schedule — it's a wish list. And a team that stops updating the schedule has usually already given up on the idea that the schedule reflects truth.

**Fix:** Make schedule updates a team ritual, not a management exercise. Normalize saying "this task slipped two days because we found an EMI issue." The goal isn't punishment-free reporting — it's accurate signal.

---

### 2. Priorities Are Never Actually Stated

Here's a scenario I've watched play out at least a dozen times:

Program has three open problems: (1) a BOM cost issue, (2) a mechanical fit problem with the enclosure, and (3) a suspected timing issue on a critical interface. All three "need to be resolved before next milestone."

The engineer working the timing issue spends three days proving it's not a real problem. Meanwhile, the enclosure issue causes a prototype build to go on hold for a week. The delay costs more than the BOM savings would have saved.

Who set the wrong priority? Nobody, technically. No one said in writing "timing first." But everyone assumed someone else was making that call.

Hardware teams operating at pace don't have time to infer priorities. If you're leading a team and you're not explicitly, regularly, and redundantly communicating what matters most right now — you are generating noise, not signal.

**Fix:** State priorities in writing, every week, at the level of specificity that's actually useful. Not "deliver the prototype" — that's always the priority. "Get the enclosure fit resolved before anything else so the build doesn't slip again."

---

### 3. Context Doesn't Cross Discipline Boundaries

Hardware engineering is inherently cross-functional. The PCB layout decisions affect the mechanical envelope. The firmware choices affect the power budget. The manufacturing process affects the tolerance stack.

But most teams are organized by discipline, and disciplines don't talk enough. Not because engineers are territorial (they sometimes are, but that's a different problem) — but because there's no structured mechanism for cross-functional signal to flow.

The mechanical team finishes their design. The PCB team finishes theirs. They meet at integration and discover interference they both could have predicted six weeks earlier if they'd had a twenty-minute conversation.

**Fix:** Make cross-functional sync a design-phase ritual, not an integration-phase fire drill. A weekly "what changed this week that other disciplines need to know" takes twenty minutes and prevents weeks of rework. 

---

## A Note on Technical Leadership

If you're a technical lead — not a people manager, but the person who owns the architecture and the design — you are also responsible for signal.

Your job isn't just to make the right technical decisions. It's to make sure those decisions are communicated with enough clarity and completeness that the rest of the team can execute without bottlenecking through you.

I've watched very strong engineers become signal bottlenecks. They make great decisions, but they don't document them, don't broadcast them, and don't create feedback loops that catch misinterpretations before they become assembly failures.

The best technical leads I've worked with treat communication as an engineering problem with specs and verification steps. "Did I communicate this decision clearly enough that the layout engineer can execute it without asking me a question?" If the answer is no, the design review isn't done.

---

## Fixing a Signal Problem Looks Different Than Fixing a Skills Problem

When you diagnose a skills problem, you hire or train. That's a slow, expensive intervention that takes months to affect output.

When you diagnose a signal problem, you change processes, meeting structures, and communication habits. These interventions can show effects in days. A team that was shipping noise starts shipping signal. Decisions get made faster because they're based on better information. Blockers surface sooner. The schedule becomes a tool rather than a theater prop.

I'm not saying skills don't matter. They do. But I've watched teams with very modest individual talent ship excellent products because the information flowing through the team was excellent. And I've watched teams full of talented people waste months because nobody could get a clear read on what was happening.

Fix your signal first. You might find you didn't have a skills problem after all.

---

*Jon Mash is the founder of [Mash Engineering LLC](https://mashpcb.com), a turnkey hardware engineering consultancy based in Washington state. He consults on complex hardware programs across aerospace, public safety, medical devices, and renewable energy.*
