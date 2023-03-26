local radio = require('radio')



local wwv10 = false

-- WWV10 offset by 1000Hz so we pick up the carrier as a 1kHz tone
-- my device seems to average about 0.3 Hz too high
local frequency = 15e6 - 1000
-- determined empirically based on signal conditions and my
-- active loop using the 5v bias T in the RSPdx
local gain = 15
local gr = 55

if wwv10 then
    frequency = 10e6 - 1000
    gain = 15
    gr = 30
end
-- treat it as usb since we tuned below
local sideband = 'usb'
-- with a NO IF sdr there is a spike right at the center frequency
-- move a smidge away to avoid that (though not really a problem
-- with what we are doing here)
local tune_offset = -100e3
-- only a 2kHz bandwidth. The 128 tap filter below is pretty soft
-- otherwise we could tighten this up
local bandwidth = 2e3


-- sample rate is 2MHz, the lowest without on device decimation
-- testing with SDRUno on windows always showed an increase in the frequency
-- measurement if FlDigi (about +1 Hz) when hardware decimation was used
-- instead rely on the decimation below in the TunerBlock
local rsp_dx_sample_rate = 2e6
local decimate = 10

-- NOTE: Most of the device setup is hardcoded in sdrplay.lua
--  like turning on the bias-T; the notch filters and IF AGC
-- search for "-- Configure device parameters"
local source = radio.SDRplaySource(frequency + tune_offset, 
                                        rsp_dx_sample_rate, 
                                        {
                                            gain_reduction = gr
                                        }
                                    )

local tuner = radio.TunerBlock(tune_offset, 2*bandwidth, decimate)
local sb_filter = radio.ComplexBandpassFilterBlock(129, (sideband == "lsb") and {0, -bandwidth}
                                                                             or {0, bandwidth})
local am_demod = radio.ComplexToRealBlock()
local af_filter = radio.LowpassFilterBlock(128, bandwidth)
-- use fixed gain and let FlDigi do it's own thing
local af_gain = radio.MultiplyConstantBlock(gain)
--local af_gain = radio.AGCBlock('slow')

-- useful debugging tools
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
