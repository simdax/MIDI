(
// //a first b second
// 0: maj/min, [a]
// 1: maj7, [b]
// 2: 7,    [b]
// 3: min,  [a]
// 4: maj,  [a]
// 5: maj/min, [b]
// 6: dim,  [a]

// =>

a=[\majmin, \maj, \7, \min, \maj, \majmin, \dim];
// 1=second note -1=first
b=[-1,1,1,-1,-1,1,0,-1,1,1,-1,-1];
a=a++(a.drop(-1).reverse).drop(-1);
~regleCouleurs=(couleurs:a, rootNote:b);

~couleurs=(
maj: [0,4,7], min: [0,3,7], \7:[0,4,7,10],
majmin: {arg s; var res=[\maj, \min].choose; s.perform(res)},
dim: Array.series(4,0,3)
);

~get={arg a, b;
	var int=absdif(a,b);
	var root= ~regleCouleurs[\rootNote][int];
	
	[a, b].sort.perform(root.switch(1, \maxItem, -1, \minItem, \choose))
	+ ~couleurs.perform(
		~regleCouleurs[\couleurs][int%12]
	) 
}
)

(
var a=0;
Pbind(\midinote, Pfunc{(60-(
	12*2))+a=12.rand}, \dur, 4, \legato, 1.1).midi(5,1).play;
MIDIdef.noteOn(\prout,
	{ arg ...args;
		var chord=~get.(a.postln, args[1]%12);
		(type:\midi, midinote:chord+60, midiout:~mOut).play
	})
)

