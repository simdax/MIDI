(
// change en note + octave

// ça c'est la stratégie, à une note de l'échelle correspond un degré fort
~a=(
convertMIDI:{
	arg t, val;
	val%12
},
note2Chord:{arg s, note;
	60+
	[0,\x, 1, \x ,0,-1,\x, 1,\x, -1,\x, 1].at(s.convertMIDI(note))
	.switch(0,[0,4,7],1,[-1,2,7],-1,[0,5,9])
}
);

// version intervallique styléée
"./noteConv.scd".loadRelative;

~b=(
	// les deux choses possibles : on est en mode majeur ou en mineur
	// et le premier accord est majeur ou mineur
	// TODO pour l'instant, que mode majeur
	// et pour l'instant en do
	root:0,
	mode:\major, //[\maj, \min].choose,
	// ensuite la note de triade de la note de la mélodie actuelle
	triade: Pseq([0,1,2], inf).iter,
	// les fonctions
	scale: {arg s; Scale.at(s.mode).degrees+s.root},
	degree:{arg s;
		try{
			var res=s.scale.indexOf(s.pitch%12) - (s.triade.next*2);
			if(res==s.prevDeg){
				"p".postln;
			};
			s.prevDeg=res;
			res
		}
	},
	accord:{arg s;
		var deg=s.degree;
		if(deg.postln.isNil)
		{Array.series(4, s.pitch%12,3)}
		{s.scale@@([0,2,4]+deg)}
	},
	// pour l'instant on s'embête pas
	note2Chord:{ arg s, p;
		var res;
		s.pitch=(p); 
		res=s.accord+60;
		~voiceLead.mvts(res).postln;
		res
	}
)

)


