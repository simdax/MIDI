(
~goEcho={
	Pbind(
		\type, \midi, \midiout, ~mOut,
		\chan, 1,
		\midinote, ~phrases.last.flop[0].iter,
		\dur, ~phrases.last.flop[1].differentiate.drop(1).add(1).iter,
	)
};

// une routine qui calcule sa moyenne au fur et à mesure

~meanR=r{
	arg inval;
	var array,mean;
	loop{
		array=array.add(inval);
		inval=array.differentiate.drop(1).mean.yield;
	}
};
)

