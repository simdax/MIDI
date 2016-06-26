(

~chrono=TempoClock(); ~offset=nil;
Pbind(\degree,20 ).play(~chrono);
MIDIdef.noteOn(\z, {
	~offset ?? {~offset=~chrono.beats%4}
}).permanent_(true)

)

