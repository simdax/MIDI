(
~voiceLead=(
	mvts:{
		arg s, chord; var p;
		if(s.prevChord.isNil){s.prevChord=chord};
		p=s.prevChord;
		chord=chord.copy;
		[p, chord].do(_.sort);
		s.prevChord=chord;
		chord-p;
	}
);
/*
a=~voiceLead.copy;
a.mvts([0,5,1]);
a.mvts([10,7,0])
	*/
)
