// =====================================================================
// SuperCollider Workspace
// =====================================================================



(
var routine;
var mOut=MIDIOut(5);

"./conversion.scd".load;

mOut.latency=0;

~phrases=nil; ~beats=0;

MIDIdef.noteOn(\a, {arg ...args;
	//restart routine
	routine.stop;
	routine=b.value.play;
	
	// play
	(midinote:~b.note2Chord(args[1]),
		type:\midi, midiout:mOut ).play(0);
	
	// store
	~mem=~mem.add([args[1], ~beats])
});

b={	
	Task({
		var clock=TempoClock();
		var now=0;
		while{
			now=clock.beats-now;
			~beats=now;
			now<1;
		}{
			0.005.wait
		};
		~phrases=~phrases.add(
			~mem
		);
		"ajouté : ".post; ~phrases.last.postln;
		~mem=nil; ~beats=0
	})}
)





