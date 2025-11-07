# ⌚ Simple Health Watchface

![Build](https://github.com/RunningBrute/garmin-health-watchface/actions/workflows/build.yml/badge.svg)

A minimal Garmin Connect IQ watchface displaying time, steps, heart rate, stress level and SpO₂.  
Just a starter template for experimenting with watch data and custom views.

---

## 🚀 Quick Start

1. **Install the SDK**
   Download and install Garmin Connect IQ SDK Manager (f.e. `https://developer.garmin.com/downloads/connect-iq/sdks/connectiq-sdk-win-8.3.0-2025-09-22-5813687a0.zip`)

2. **Set PATH**
   ```powershell
   setx PATH "path\to\your\garmin\sdk\bin;%PATH%"
   ```

3. **Build the project**
   ```powershell
   connectiq build
   ```

4. **Run in simulator**
   ```powershell
   connectiq simulate bin\garmin-health-watchface.prg
   ```

5. **Load on your watch** 
   - Connect your device via USB  
   - Copy the `.prg` to `/GARMIN/APPS/`

---