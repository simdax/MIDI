// =====================================================================
// SuperCollider Workspace
// =====================================================================



(
var routine;


"./conversion.scd".loadRelative;
"./echo.scd".loadRelative;

~phrases=nil; ~beats=0;
~note=0;

MIDIdef.noteOn(\a, {arg ...args;
	//restart routine
	routine.stop;
	routine=b.value.play;

	if(~beats==0){
		~main=thisThread.beats
	};
	
	// note
	~note=args[1].postln;

	// store
	~mem=~mem.add([args[1], thisThread.beats]);
	// analyse
	~meanR.next(~mem.last[1]).postln;
	
});

b={	
	r{
		var clock=TempoClock();
		var now=0;

		/// loop
		while{
			now=clock.beats-now;
			~beats=now;// ~beats.postln;
			now<0.5;
		}{
			0.005.wait
		};
		~phrases=~phrases.add(
			~mem
		);
		
		// finalization
		"ajouté : ".post; ~phrases.last.postln;
		// echo
		~goEcho.value.play(~chrono, quant:[4,~offset]); ~offset=nil;
		// clean
		~mem=nil; ~beats=0; ~meanR.reset
	}
};

)





