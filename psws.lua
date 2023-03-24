local radio = require('radio')

if #arg < 2 then
    io.stderr:write("Usage: " .. arg[0] .. " <frequency> <sideband>\n")
    os.exit(1)
end

assert(arg[2] == "usb" or arg[2] == "lsb", "Sideband should be 'lsb' or 'usb'.")

local frequency = tonumber(arg[1])
local sideband = arg[2]
local tune_offset = -100e3
local bandwidth = 3e3
local gain = 15
-- demo code used 50
-- we reduced bandwidth and went with more samples
local decimate = 10
-- Blocks
--local source = radio.RtlSdrSource(frequency + tune_offset, 1102500)
-- -- Source samples from 144.390 MHz sampled at 4 MHz, with 0.6 MHz bandwidth
-- using debug mode this ends up matching 300kHz bandwidth, which is just fine for what
-- we need
local source = radio.SDRplaySource(frequency + tune_offset, 2e6, {bandwidth = 0.6e6, gain_reduction = 0})

local tuner = radio.TunerBlock(tune_offset, 2*bandwidth, decimate)
local sb_filter = radio.ComplexBandpassFilterBlock(129, (sideband == "lsb") and {0, -bandwidth}
                                                                             or {0, bandwidth})
local am_demod = radio.ComplexToRealBlock()
local af_filter = radio.LowpassFilterBlock(128, bandwidth)
local af_gain = radio.MultiplyConstantBlock(gain)
--local af_gain = radio.AGCBlock('slow')
--local sink = os.getenv('DISPLAY') and radio.PulseAudioSink(1) or radio.WAVFileSink('ssb.wav', 1)
local sink = radio.PulseAudioSink(1) 

-- plotting disabled due to high cpu use
-- Plotting sinks
--local plot1 = radio.GnuplotSpectrumSink(2048, 'RF Spectrum', {xrange = {-3100,
--                                                                        3100},
--                                                              yrange = {-120, -40}})
--local plot2 = radio.GnuplotSpectrumSink(2048, 'AF Spectrum', {yrange = {-120, -40},
--                                                              xrange = {0, bandwidth},
--                                                              update_time = 0.05})

-- Connections
local top = radio.CompositeBlock()
top:connect(source, tuner, sb_filter, am_demod, af_filter, af_gain, sink)
if os.getenv('DISPLAY') then
--    top:connect(tuner, plot1)
--    top:connect(af_gain, plot2)
end

top:run()
