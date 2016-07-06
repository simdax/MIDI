(
s.boot;

~dur=nil; ~bob=nil; ~go=nil;

~r=r{
	
	loop{
		if(~bob[1].postln.notNil, {
			var plot;
			~dur ?? {~dur=~bob[1]-~bob[0]};
			defer{plot=[0].plot};
			loop{
				~variance=~bob.differentiate.drop(1) - ~dur;
				defer{plot.setValue(~variance, minval:-0.3, maxval:0.7)};
				~variance.yield;
			}
		},
			{
				0.yield
			})
	}
};
	
MIDIdef.noteOn(\tempo, {
	arg ...args;
	//
	~go ?? {
		Pbind(\degree, -10).midi(5,0).play; ~go=true;
		 ~depart=thisThread.beats;
	};
	~bob=~bob.add(thisThread.beats-~depart);
	if(~bob.size > 10, {
		~bob.removeAt(0)
	});
	~r.next;
})

)

