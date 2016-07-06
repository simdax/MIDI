/// ça ça calcule des durées pondérées

(
var duree=1;
~r=r{ arg inval;
	var f;
	f=inval; 0.yield;
	loop{
		var res= (inval-f).round(0.25);
		inval=res.yield;
	}
};
MIDIdef.noteOn(\io, {arg ...i;
	~r.next(thisThread.beats).postln	
})
)