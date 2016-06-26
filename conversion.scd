(
// change en note + octave

// ça c'est la stratégie, à une note de l'échelle correspond un degré fort
~a=(
	convertDeg:{
		arg s, deg;
		switch(deg%7,
			1,4,2,0,6,4,
			deg
		); 
	}
);

// version intervallique styléée
"./noteConv.scd".loadRelative;
"./voiceLeading.scd".loadRelative;

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
	scale: {arg s; (Scale.at(s.mode).degrees+s.root)%12},
	degree:{arg s;
		try{
			var res=s.scale.indexOf(s.pitch%12) - (s.triade.next*2);
			if(res==s.prevDeg){
				"same degree".postln;
			};
			res=~a.convertDeg(res);
			s.prevDeg=res; res;
		}
	},
	accord:{arg s;
		var deg=s.degree;
		if(deg.isNil)
		{Array.series(4, s.pitch%12,3)}
		{s.scale@@([0,2,4]+deg)}
	},
	// pour l'instant on s'embête pas
	note2Chord:{ arg s, p;
		var res;
		s.pitch=(p); 
		res=s.accord+60;
		~voiceLead.mvts(res).postln;
		//		("triade, degree :"++[s.tri, s.degree]).postln;
		res
	}
)

)

