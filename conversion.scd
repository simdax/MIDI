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
"./noteConv.scd".load;

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
	degree:{arg s; s.scale.indexOf(s.pitch%12) - (s.triade.next)},
	// pour l'instant on s'embête pas
	basse:{arg s; s.degree},
	asStr:{ arg s, args;
		r{ 
			var pitches=Pseq(args, inf).iter;
			loop{
				s.pitch=(pitches.next.postln); s.basse.yield;
			}
		}
	}
)//.asStr([60,62,64,65,67].scramble.postln).iter.nextN(8)

)


