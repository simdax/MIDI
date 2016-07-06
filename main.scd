(
var pat, a, b;

"./midiConnec.scd".loadRelative;
pat=Pdef(\a,
	Pbind(
			\midinote,	Pfunc{
				~b.note2Chord(~note)
			},
			\type, \midi, \midiout, ~mOut
		)
	);


a=Window().front; 
b=Button(a).action_{
	defer{pat.toggle};
	~go=thisThread.beats
}

)