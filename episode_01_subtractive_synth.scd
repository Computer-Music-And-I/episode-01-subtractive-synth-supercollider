(
Server.default.options.outDevice_("Lautsprecher (Realtek(R) Audio)");
s.boot;
)

(
SynthDef(\SooperSaw, { |out, freq = 220, gate = 1, amp = 0.7, release = 1.5|

	var vco = Saw.ar([freq, freq*1.01], mul: 1.0, add: 0.0);
    var eg2_params = Env.adsr(0.02, 0.1, 0.7, release, 1.0, -4.0);
    var eg2 = EnvGen.kr(eg2_params, gate, doneAction: Done.freeSelf);

	var eg1_freq = MouseX.kr(10, 20000, \exponential); // cutoff freq.
    var eg1_resonance =  MouseY.kr(4.0, 0.0, \linear); // rq
	var vcf =  BLowPass.ar(vco, eg1_freq, eg1_resonance, 0.5);

	Out.ar(out!2, vcf * eg2 * amp)
}).add
)

a = Synth(\SooperSaw,[\freq, 110]);
a.set(\gate, 0);
