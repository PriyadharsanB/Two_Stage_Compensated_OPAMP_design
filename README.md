# Two_Stage_Compensated_OPAMP_design

# Two-Stage Miller-Compensated CMOS Operational Amplifier — 180 nm Technology

A two-stage CMOS operational amplifier designed and simulated in LTspice using 180 nm technology, built around a differential input stage, a common-source gain stage, and Miller compensation for stability — extending the single-stage differential amplifier into a full op-amp architecture.

By Priyadharsan
---
**mentorship project as a mentee from ACM Vidyut**

---

## Overview

The amplifier uses a two-stage topology: the first stage is a CMOS differential amplifier with active load, providing initial gain and differential-to-single-ended conversion; the second stage is a common-source amplifier that adds further gain and improves output swing. A single-ended two-stage design naturally has two poles close together in frequency, which threatens closed-loop stability. A Miller compensation capacitor (Cc) is placed between the two stages to address this through pole-splitting.

Design target: **60 dB DC gain**, **>60° phase margin**, **20 V/µs slew rate**, sub-300 µW power dissipation, implemented on the TSMC 180 nm BSIM3 Level 49 model.

## Results

| Parameter | Observed Value |
|---|---|
| AC Gain | 60.43 dB |
| Phase Margin | 63.04° |
| Unity Gain Bandwidth | 28.065 MHz |
| Common Mode Gain | -14.451 dB |
| CMRR | 74.451 dB |
| Slew Rate | 20 V/µs |
| PSRR | -77.327 dB |
| Power Dissipation (no input) | 287.08 µW |
| ICMR | 0.7 V – 1.6 V |

## Insights

**AC Analysis** — The amplifier achieved 60.43 dB open-loop gain with a 63.04° phase margin, meeting the design target. Miller compensation works by reflecting Cc back to the first stage as an effective capacitance of Cc·(1+Av2), which pulls the first pole lower in frequency while pushing the second pole higher. This pole-splitting keeps the two poles separated enough that by the time the loop gain crosses 0 dB, only one pole has contributed significant phase shift — which is why the measured phase margin clears the 60° stability threshold.

**DC / ICMR Analysis** — Sweeping the input with negative feedback (unity-gain buffer) gave an ICMR of roughly 0.7 V–1.6 V. This range is bounded by the tail current source needing headroom on the low end, and the input pair approaching triode on the high end. Outside this window the DC transfer curve flattens, marking where the input stage clips.

**Common-Mode Gain & CMRR** — Common-mode gain measured -14.451 dB, giving a CMRR of 74.451 dB (CMRR = Av − Acm). An ideal tail current source would fully reject common-mode signals, but finite output resistance lets a small common-mode component modulate the tail current and leak through. The measured CMRR reflects how well the current-mirror load and tail biasing suppress this relative to true differential gain.

**Slew Rate** — A step input gave SR = ΔV/Δt = 0.12V/6ns = 20 V/µs, matching the target exactly. In a Miller-compensated amplifier, slew rate is set by how fast the tail current can charge Cc (SR ≈ I_tail/Cc) — a large-signal limit distinct from small-signal bandwidth, which is why the two were sized as separate constraints during design.

**PSRR** — PSRR came out to -77.327 dB, with a resonant bump near 100 MHz before rolling off further. Supply noise couples to the output mainly through the finite output impedance of the current mirrors and parasitic capacitances on the PMOS devices near the supply rail. The second gain stage adds loop gain that suppresses this coupling before it reaches the output — PSRR benefits from the same gain that improves signal amplification.

**Power Dissipation** — Measured at 287.08 µW with no input signal, just under the 300 µW budget. Static power (P = VDD × I_total) is set by the tail current and second-stage bias current, confirming both were sized tightly enough to meet performance targets without overspending on quiescent current.

## Circuit Architecture

- **Stage 1:** NMOS differential pair with PMOS active load (current mirror) — sets initial gain and performs differential-to-single-ended conversion
- **Stage 2:** Common-source amplifier — adds gain and extends output swing
- **Compensation:** Miller capacitor (Cc) across the two stages, performing pole-splitting for closed-loop stability
- **Biasing:** Current mirror network setting the tail current and second-stage bias point, with all devices kept in saturation across the ICMR

## Applications Simulated

- Inverting amplifier
- Integrator
- Differentiator
- Summing amplifier
- Comparator

## Tools and Software

- LTspice (180 nm TSMC BSIM3 Level 49 model)
- MATLAB (parameterized design automation — W/L ratios and bias currents computed and linked to LTspice via a parameter file)

---


