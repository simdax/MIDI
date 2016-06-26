// =====================================================================
// SuperCollider Workspace
// =====================================================================



(
var routine;
~mOut=MIDIOut(5);

"./conversion.scd".loadRelative;

~mOut.latency=0;

~phrases=nil; ~beats=0;
~note=0;

MIDIdef.noteOn(\a, {arg ...args;
	//restart routine
	routine.stop;
	routine=b.value.play;
	~note=args[1].postln;

	// play
	// (midinote:~b.note2Chord(args[1]),
	// 	type:\midi, midiout:~mOut ).play(0);
	
	// store
	~mem=~mem.add([args[1], thisThread.beats])
}).permanent_(true);

b={	
	Task({
		var clock=TempoClock();
		var now=0;
		while{
			now=clock.beats-now;
			~beats=now;
			now<0.5;
		}{
			0.005.wait
		};
		~phrases=~phrases.add(
			~mem
		);
		"ajouté : ".post; ~phrases.last.postln;
		~goEcho.value.play(~chrono, quant:[4,~offset]); ~offset=nil;
		~mem=nil; ~beats=0
	})};

~goEcho={
	Pbind(
		\type, \midi, \midiout, ~mOut,
		\midinote, ~phrases.last.flop[0].iter,
		\dur, ~phrases.last.flop[1].differentiate.drop(1).add(1).iter,
	)
};

)





