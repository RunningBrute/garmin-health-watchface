using Toybox.Application;
using Toybox.Graphics;
using Toybox.WatchUi;
using Toybox.System;
using Toybox.Sensor;
using Toybox.ActivityMonitor;

class SimpleHealthWatchApp extends Application.AppBase
{
    function getInitialView()
    {
        return [ new MainView() ];
    }
}

class MainView extends WatchUi.WatchFace
{
    var hr = null;
    var stress = null;
    var spo2 = null;
    var steps = null;

    function initialize() 

        WatchFace.initialize();
        Sensor.setEnabledSensors([Sensor.HR, Sensor.STRESS, Sensor.PULSE_OX]);
    }

    function onUpdate(dc)
    {
        var t = System.getClockTime();
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.clear();

        // Time
        var timeText = Lang.format("$1$:$2$", [pad(t.hour), pad(t.min)]);
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(dc.getWidth()/2, 50, Graphics.FONT_NUMBER_LARGE, timeText, Graphics.TEXT_JUSTIFY_CENTER);

        // Update sensors
        updateSensors();

        // Metrics
        steps = ActivityMonitor.getInfo().steps;

        var y = 120;
        dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);
        dc.drawText(dc.getWidth()/2, y, Graphics.FONT_MEDIUM, "Steps: " + steps, Graphics.TEXT_JUSTIFY_CENTER); y += 25;
        dc.drawText(dc.getWidth()/2, y, Graphics.FONT_MEDIUM, "HR: " + (hr == null ? "--" : hr) + " bpm", Graphics.TEXT_JUSTIFY_CENTER); y += 25;
        dc.drawText(dc.getWidth()/2, y, Graphics.FONT_MEDIUM, "Stress: " + (stress == null ? "--" : stress), Graphics.TEXT_JUSTIFY_CENTER); y += 25;
        dc.drawText(dc.getWidth()/2, y, Graphics.FONT_MEDIUM, "SpO₂: " + (spo2 == null ? "--" : spo2) + "%", Graphics.TEXT_JUSTIFY_CENTER);
    }

    function pad(n)
    {
        return (n < 10) ? "0" + n : n;
    }

    function updateSensors()
    {
        var h = Sensor.getHeartRateData();
        if (h != null) hr = h.current;

        var s = Sensor.getStressLevel();
        if (s != null) stress = s;

        var o = Sensor.getPulseOxData();
        if (o != null) spo2 = o.value;
    }

    function onHide()
    {
        Sensor.setEnabledSensors([]);
    }
}