/// ça ça calcule des durées pondérées

(
var f= {arg ...i;
	~dur=~dur.add(  ~r.next(thisThread.beats)	);
	defer{~statT.string_(~dur.round(~round))}
};
"metronome.scd".loadRelative;
MIDIdef.noteOn(\io).free;
~round=0;
~dur=nil;
~r=r{ arg inval;
	var first;
	var func=		{
		var res= (inval-first);//.round(0.125);
		inval=res.yield
	};
	first=inval; inval=0.yield;
	~go=first;
	3.do{func.value};
	Pdef(\metro).quant_((4-
		thisThread.beats-~go%4).postln);
	Pdef(\metro).play();
	func.loop;
};
View(nil, 300@300).layout_(HLayout(
	CheckBox(nil, 300@300)
	.string_("detecter R")
	.action_{ arg self;
		self.value.switch(
			true, {~r.reset; MIDIdef.noteOn(\io, f)},
			false, {~r.stop; MIDIdef.noteOn(\io).free}
		);
		~dur.changed(\changed)
	},
	~statT=StaticText(nil, 200@200)
	.string_(~dur),
	CheckBox().string_("normali?")
	.action_{arg self; "io".postln;
		self.value.switch(
			true, {~round=0.125},
			false, {~round=0}
		);
		~dur.changed(\changed)
	}
)).front
)


