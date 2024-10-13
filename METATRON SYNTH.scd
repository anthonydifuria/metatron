//Metatron Additive Cicloid Synth

s.boot;
Server.default.options.memSize = 8192*48;

s.scope;
s.freqscope;


(

var w,t1,t2,c1,c2,c3,c4,c5,b_onoff;
// variabili per il generatore di frequenze
var s_trig,n_trig,t_trig,max_freq,min_freq,t_max_freq,t_min_freq,s_freq_manual,t_freq_manual,n_freq_manual,s_spread_manual,n_spread_manual,t_spread_manual,b_sel_gen,s_trig_spread,t_trig_spread,n_trig_spread;

// variabili mixer
var s_cerchio1,s_cerchio2,s_cerchio3,s_cerchio4,s_cerchio5,s_cerchi_gruppoA,s_cerchi_gruppoB,s_cicloidiA,s_cicloidiB,t_cerchio1,t_cerchio2,t_cerchio3,t_cerchio4,t_cerchio5,t_cerchi_gruppoA,t_cerchi_gruppoB,t_cicloidiA,t_cicloidiB,
t_vel_cerchiA,s_vel_cerchiA,n_vel_cerchiA,t_vel_cerchiB,s_vel_cerchiB,n_vel_cerchiB,
t_rev,s_rev,t_mix_rev,t_damp,t_room,s_damp,s_room,t_volume,s_volume;

//variabili granulazione cerchi
var b_grain_cerchi,b_grain_gruppi,b_grain_cicloidi,t_dens,t_dur,s_dens,s_dur,n_dens,n_dur,t_spread_dens,s_spread_dens,t_min_dens,t_max_dens,n_min_dens,n_max_dens,t_spread_dur,s_spread_dur,t_min_dur,t_max_dur,n_min_dur,n_max_dur,t_spread_pan,s_spread_pan,t_trig_dens,t_trig_dur,n_trig_dens,n_trig_dur;

//variabili granulazione gruppi cerchi

var t_primo_gruppo,t_secondo_gruppo,t_dens_cerchio1a,t_dens_cerchio2a,t_dens_cerchio3a,t_dens_cerchio4a,t_dens_cerchio5a,t_dens_cerchio6a,t_dens_cerchio1b,t_dens_cerchio2b,t_dens_cerchio3b,t_dens_cerchio4b,t_dens_cerchio5b,t_dens_cerchio6b,t_dur_cerchio1a,t_dur_cerchio2a,t_dur_cerchio3a,t_dur_cerchio4a,t_dur_cerchio5a,t_dur_cerchio6a,t_dur_cerchio1b,t_dur_cerchio2b,t_dur_cerchio3b,t_dur_cerchio4b,t_dur_cerchio5b,t_dur_cerchio6b,n_dens_cerchio1a,n_dens_cerchio2a,n_dens_cerchio3a,n_dens_cerchio4a,n_dens_cerchio5a,n_dens_cerchio6a,n_dens_cerchio1b,n_dens_cerchio2b,n_dens_cerchio3b,n_dens_cerchio4b,n_dens_cerchio5b,n_dens_cerchio6b,n_dur_cerchio1a,n_dur_cerchio2a,n_dur_cerchio3a,n_dur_cerchio4a,n_dur_cerchio5a,n_dur_cerchio6a,n_dur_cerchio1b,n_dur_cerchio2b,n_dur_cerchio3b,n_dur_cerchio4b,n_dur_cerchio5b,n_dur_cerchio6b,t_spread_densA,t_spread_durA,t_spread_densB,t_spread_durB,s_spread_densA,s_spread_durA,s_spread_densB,s_spread_durB,t_min_spreadA_dens,t_max_spreadA_dens,t_min_spreadB_dens,t_max_spreadB_dens,n_min_spreadA_dens,n_max_spreadA_dens,n_min_spreadB_dens,n_max_spreadB_dens,t_min_spreadA_dur,t_max_spreadA_dur,t_min_spreadB_dur,t_max_spreadB_dur,n_min_spreadA_dur,n_max_spreadA_dur,n_min_spreadB_dur,n_max_spreadB_dur,k_spread_panA,t_spread_panA,k_spread_panB,t_spread_panB,t_trigA,t_trigB,n_trigA,n_trigB;

//variabili cicloidi

var t_cicloidi_gruppoA,t_cicloidi_gruppoB,k_vel_cicloide1a,k_vel_cicloide2a,k_vel_cicloide3a,k_vel_cicloide4a,k_vel_cicloide5a,k_vel_cicloide6a,k_vel_cicloide1b,k_vel_cicloide2b,k_vel_cicloide3b,k_vel_cicloide4b,k_vel_cicloide5b,k_vel_cicloide6b,t_vel1,t_vel2,t_vel3,t_vel4,t_vel5,t_vel6;

//GUI generale
w = GUI.window.new("METATRON SYNTH", Rect(10,10,1400,1000)); w.front;

c1 = CompositeView(w, Rect(10, 10, 300, 400));  c1.background = Color.black;
c2 = CompositeView(w, Rect(320, 10, 1070, 400));  c2.background = Color.black;
c3 = CompositeView(w, Rect(10, 420, 300, 420));  c3.background = Color.black;
c4 = CompositeView(w, Rect(320, 420, 630, 420));  c4.background = Color.black;
c5 = CompositeView(w, Rect(960, 420, 430, 420));  c5.background = Color.black;


t1 = StaticText(w, Rect(60, 20, 200, 20)); t1.string = "FREQUENCY GENERATOR"; t1.background  = Color.red; t1.align_(\center);
t2 = StaticText(w, Rect(770, 20, 200, 20)); t2.string = "MIXER"; t2.background  = Color.red; t2.align_(\center);


b_onoff = Button(w, Rect(1320,20,60,20));
b_onoff.states_([["ON", Color.red, Color.black],["OFF", Color.black, Color.red]]);
b_onoff.action_({
	arg me;
	var val = me.value.postln ;
	if(val == 0){x.run(false)}{x.run(true)}
});



//GUI generatore frequenze
b_sel_gen = Button(c1, Rect(50,40 ,200 , 20));

b_sel_gen.states_([["Manual Frequency", Color.red, Color.black],["Randomic Frequency", Color.black, Color.red]]);
b_sel_gen.action_({
	arg me ;
	var val = me.value.postln ;
	if(val == 0){x.set(\sel_gen0, me.value)}{x.set(\sel_gen0, me.value)};
	if(val == 0){x.set(\sel_gen1, 1)}{x.set(\sel_gen1, 0)}
});



t_trig = GUI.staticText.new(c1, Rect(240, 70, 50, 15)).string_("Trig Vel").align_( \center );t_trig.background = Color.white;
s_trig = GUI.slider.new(c1, Rect(10, 68, 160, 20)); s_trig.value = 0;
s_trig.action_({ arg me; var v = me.value.linlin(0,1,0,10).postln; n_trig.value = v ; x.set(\vel_trig, v.value);});
n_trig = GUI.numberBox.new( c1, Rect( 183, 68, 50, 20 )).string_("Trig Vel").align_( \center );
n_trig.value = 0;
n_trig.action_({arg v; x.set(\vel_trig, v.value); });



t_max_freq = GUI.staticText.new(c1, Rect(160, 100, 70, 15)).string_("Max Freq").align_( \center );t_max_freq.background = Color.white;
t_min_freq = GUI.staticText.new(c1, Rect(20, 100, 70, 15)).string_("Min Freq").align_( \center );t_min_freq.background = Color.white;
max_freq = GUI.numberBox.new( c1, Rect( 100, 98, 50, 20 )).string_("max").align_( \center );
max_freq.value = 40;
max_freq.action_({arg v; x.set(\max_freq, v.value); });
min_freq = GUI.numberBox.new( c1, Rect( 240, 98, 50, 20 )).string_("min").align_( \center );
min_freq.value = 200;
min_freq.action_({arg v; x.set(\min_freq, v.value); });

t_freq_manual = GUI.staticText.new(c1, Rect(70, 140, 150, 15)).string_("Manual Frequency").align_( \center );t_freq_manual.background = Color.white;
s_freq_manual = GUI.slider.new(c1, Rect(10, 160, 220, 20)); s_freq_manual.value = 0;
s_freq_manual.action_({ arg me; var v = me.value.linlin(0,1,20,5000).postln; n_freq_manual.value = v ; x.set(\fond, v.value);});
n_freq_manual = GUI.numberBox.new( c1, Rect( 240, 160, 50, 20 )).string_("man freq").align_( \center );
n_freq_manual.value = 20;
n_freq_manual.action_({arg v; x.set(\fond, v.value); });

t_spread_manual = GUI.staticText.new(c1, Rect(55, 190, 180, 15)).string_("Spread Manual Frequency").align_( \center );t_spread_manual.background = Color.white;
s_spread_manual = GUI.slider.new(c1, Rect(10, 210, 220, 20)); s_spread_manual.value = 0;
s_spread_manual.action_({ arg me; var v = me.value.linlin(0,1,0,1).postln;  x.set(\spread_amp, v.value);});
n_spread_manual = GUI.numberBox.new( c1, Rect( 240, 210, 50, 20 )).string_("man freq").align_( \center );
n_spread_manual.value = 20;
n_spread_manual.action_({arg v; x.set(\spread_freq, v.value); });

t_trig_spread = GUI.staticText.new(c1, Rect(120, 240, 60, 15)).string_("Trig Vel").align_( \center );
t_trig_spread.background = Color.white;
s_trig_spread = GUI.slider.new(c1, Rect(10, 260, 220, 20));
s_trig_spread.value = 0;
s_trig_spread.action_({ arg me; var v = me.value.linlin(0,1,0,10).postln; n_trig_spread.value = v ; x.set(\vel_trig_spread, v.value);});
n_trig_spread = GUI.numberBox.new( c1, Rect( 240, 260, 50, 20 )).string_("Trig Vel").align_( \center );
n_trig_spread.value = 0;
n_trig_spread.action_({arg v; x.set(\vel_trig_spread, v.value); });





//MIXER


t_volume = GUI.staticText.new(c2, Rect(1010, 60, 40, 20)).string_("OUT").align_( \center );
t_volume.background = Color.red;
t_cerchio1 = GUI.staticText.new(c2, Rect(10, 40, 60, 45)).string_("CERCHIO 1").align_( \center );
t_cerchio1.background = Color.red;
t_cerchio2 = GUI.staticText.new(c2, Rect(80, 40, 60, 45)).string_("CERCHIO 2").align_( \center );
t_cerchio2.background = Color.red;
t_cerchio3 = GUI.staticText.new(c2, Rect(150, 40, 60, 45)).string_("CERCHIO 3").align_( \center );
t_cerchio3.background = Color.red;
t_cerchio4 = GUI.staticText.new(c2, Rect(220, 40, 60, 45)).string_("CERCHIO 4").align_( \center );
t_cerchio4.background = Color.red;
t_cerchio5 = GUI.staticText.new(c2, Rect(290, 40, 60, 45)).string_("CERCHIO 5").align_( \center );
t_cerchio5.background = Color.red;
t_cerchi_gruppoA = GUI.staticText.new(c2, Rect(360, 40, 60, 45)).string_("CERCHI GRUPPO A").align_( \center );
t_cerchi_gruppoA.background = Color.red;
t_cerchi_gruppoB = GUI.staticText.new(c2, Rect(430, 40, 60, 45)).string_("CERCHI GRUPPO B").align_( \center );
t_cerchi_gruppoB.background = Color.red;
t_cicloidiA = GUI.staticText.new(c2, Rect(500, 40, 60, 45)).string_("CICLOIDI GRUPPO A").align_( \center );
t_cicloidiA.background = Color.red;
t_cicloidiB = GUI.staticText.new(c2, Rect(570, 40, 60, 45)).string_("CICLOIDI GRUPPO B").align_( \center );
t_cicloidiB.background = Color.red;

s_volume = GUI.slider.new(c2, Rect(1010, 90, 40, 300));s_volume.value = 0;
s_volume.action_({ arg me; var v = me.value.linlin(0,1,0,1).postln;  x.set(\volume, v.value);});
s_cerchio1 = GUI.slider.new(c2, Rect(20, 90, 40, 300));s_cerchio1.value = 1;
s_cerchio1.action_({ arg me; var v = me.value.linlin(0,1,0,1).postln;  x.set(\cerchio_amp1, v.value);});
s_cerchio2 = GUI.slider.new(c2, Rect(90, 90, 40, 300));s_cerchio2.value = 1;
s_cerchio2.action_({ arg me; var v = me.value.linlin(0,1,0,1).postln;  x.set(\cerchio_amp2, v.value);});
s_cerchio3 = GUI.slider.new(c2, Rect(160, 90, 40, 300));s_cerchio3.value = 1;
s_cerchio3.action_({ arg me; var v = me.value.linlin(0,1,0,1).postln;  x.set(\cerchio_amp3, v.value);});
s_cerchio4 = GUI.slider.new(c2, Rect(230, 90, 40, 300));s_cerchio4.value = 1;
s_cerchio4.action_({ arg me; var v = me.value.linlin(0,1,0,1).postln;  x.set(\cerchio_amp4, v.value);});
s_cerchio5 = GUI.slider.new(c2, Rect(300, 90, 40, 300));s_cerchio5.value = 1;
s_cerchio5.action_({ arg me; var v = me.value.linlin(0,1,0,1).postln;  x.set(\cerchio_amp5, v.value);});
s_cerchi_gruppoA = GUI.slider.new(c2, Rect(370, 90, 40, 300));s_cerchi_gruppoA.value = 1;
s_cerchi_gruppoA.action_({ arg me; var v = me.value.linlin(0,1,0,1).postln;  x.set(\cerchi_gruppoA, v.value);});
s_cerchi_gruppoB = GUI.slider.new(c2, Rect(440, 90, 40, 300));s_cerchi_gruppoB.value = 1;
s_cerchi_gruppoB.action_({ arg me; var v = me.value.linlin(0,1,0,1).postln;  x.set(\cerchi_gruppoB, v.value);});
s_cicloidiA = GUI.slider.new(c2, Rect(510, 90, 40, 300));s_cicloidiA.value = 1;
s_cicloidiA.action_({ arg me; var v = me.value.linlin(0,1,0,1).postln;  x.set(\cicloidiA, v.value);});
s_cicloidiB = GUI.slider.new(c2, Rect(580, 90, 40, 300));s_cicloidiB.value = 1;
s_cicloidiB.action_({ arg me; var v = me.value.linlin(0,1,0,1).postln;  x.set(\cicloidiB, v.value);});


t_vel_cerchiA = GUI.staticText.new(c2, Rect(700, 40, 100, 15)).string_("VEL CERCHI A").align_( \center );
t_vel_cerchiA.background = Color.white;
s_vel_cerchiA = GUI.slider.new(c2, Rect(650, 65, 220, 20));
s_vel_cerchiA.value = 0.5;
s_vel_cerchiA.action_({ arg me; var v = me.value.linlin(0,1,-10,10).postln; n_vel_cerchiA.value = v ; x.set(\vel_ampA, v.value); x.set(\vel_phaseA, v.value); });
n_vel_cerchiA = GUI.numberBox.new( c2, Rect( 870, 65, 50, 20 )).string_("vel cerchi A").align_( \center );
n_vel_cerchiA.value = 0;
n_vel_cerchiA.action_({arg v; x.set(\vel_ampA, v.value);x.set(\vel_phaseA, v.value); });

t_vel_cerchiB = GUI.staticText.new(c2, Rect(700, 90, 100, 15)).string_("VEL CERCHI B").align_( \center );
t_vel_cerchiB.background = Color.white;
s_vel_cerchiB = GUI.slider.new(c2, Rect(650, 115, 220, 20));
s_vel_cerchiB.value = 0.5;
s_vel_cerchiB.action_({ arg me; var v = me.value.linlin(0,1,-10,10).postln; n_vel_cerchiB.value = v ; x.set(\vel_ampB, v.value); x.set(\vel_phaseB, v.value); });
n_vel_cerchiB = GUI.numberBox.new( c2, Rect( 870, 115, 50, 20 )).string_("vel cerchi A").align_( \center );
n_vel_cerchiB.value = 0;
n_vel_cerchiB.action_({arg v; x.set(\vel_ampB, v.value);x.set(\vel_phaseB, v.value); });


t_rev = GUI.staticText.new(c2, Rect(700, 180, 100, 15)).string_("REV").align_( \center );t_rev.background = Color.white;
t_mix_rev = GUI.staticText.new(c2, Rect(870, 210, 50, 15)).string_("MIX").align_( \center );t_mix_rev.background = Color.white;
t_damp = GUI.staticText.new(c2, Rect(870, 240, 50, 15)).string_("DAMP").align_( \center );t_damp.background = Color.white;
t_room = GUI.staticText.new(c2, Rect(870, 270, 50, 15)).string_("ROOM").align_( \center );t_room.background = Color.white;

s_rev = GUI.slider.new(c2, Rect(650, 207, 220, 20));s_rev.value = 0;
s_damp = GUI.slider.new(c2, Rect(650, 237, 220, 20));s_damp.value = 0.5;
s_room = GUI.slider.new(c2, Rect(650, 267, 220, 20));s_room.value = 0;

s_rev.action_({ arg me; var v = me.value.linlin(0,1,0,1).postln; x.set(\mix, v.value); });
s_damp.action_({ arg me; var v = me.value.linlin(0,1,0,1).postln; x.set(\damp, v.value);  });
s_room.action_({ arg me; var v = me.value.linlin(0,1,0,1).postln; x.set(\room, v.value); });

//GRANULAZIONI

//granulazione cerchi!!!!

b_grain_cerchi = Button(c3, Rect(50,10 ,200 , 20));
b_grain_cerchi.states_([["GRAIN CERCHI on", Color.red, Color.black],["GRAIN CERCHI off", Color.black, Color.red]]);
b_grain_cerchi.action_({
	arg me ;
	var val = me.value.postln ;
	if(val == 0){x.set(\grain_cerchi, me.value)}{x.set(\grain_cerchi, me.value)};

});


t_dens = GUI.staticText.new(c3, Rect(50, 40, 50, 15)).string_("DENS").align_( \center );t_dens.background = Color.white;
t_dur = GUI.staticText.new(c3, Rect(50, 170, 50, 15)).string_("DUR").align_( \center );t_dur.background = Color.white;
t_spread_dens = GUI.staticText.new(c3, Rect(50, 90, 120, 15)).string_("SPREAD DENS").align_( \center );t_spread_dens.background = Color.white;
t_min_dens = GUI.staticText.new(c3, Rect(40, 140, 50, 15)).string_("MIN").align_( \center );t_min_dens.background = Color.white;
t_max_dens = GUI.staticText.new(c3, Rect(160, 140, 50, 15)).string_("MAX").align_( \center );t_max_dens.background = Color.white;
t_spread_dur = GUI.staticText.new(c3, Rect(50, 220, 120, 15)).string_("SPREAD DUR").align_( \center );t_spread_dur.background = Color.white;
t_min_dur = GUI.staticText.new(c3, Rect(40, 270, 50, 15)).string_("MIN").align_( \center );t_min_dur.background = Color.white;
t_max_dur = GUI.staticText.new(c3, Rect(160, 270, 50, 15)).string_("MAX").align_( \center );t_max_dur.background = Color.white;
t_spread_pan = GUI.staticText.new(c3, Rect(50, 300, 100, 15)).string_("SPREAD PAN").align_( \center );t_spread_pan.background = Color.white;
t_trig_dens = GUI.staticText.new(c3, Rect(50, 360, 100, 15)).string_("VEL TRIG DENS").align_( \center );t_trig_dens.background = Color.white;
t_trig_dur = GUI.staticText.new(c3, Rect(160, 360, 100, 15)).string_("VEL TRIG DUR").align_( \center );t_trig_dur.background = Color.white;

s_dens = GUI.slider.new(c3, Rect(10, 60, 220, 20));s_dens.value = 0;
s_dur = GUI.slider.new(c3, Rect(10, 190, 220, 20));s_dur.value = 0.1;
s_spread_dens = GUI.slider.new(c3, Rect(10, 110, 280, 20));s_spread_dens.value = 0;
s_spread_dur = GUI.slider.new(c3, Rect(10, 240, 280, 20));s_spread_dur.value = 0;
s_spread_pan = GUI.slider.new(c3, Rect(10, 320, 280, 20));s_spread_pan.value = 0;

s_dens.action_({ arg me; var v = me.value.linlin(0,1,0.1,50).postln; x.set(\dens, v.value); n_dens.value = v });
s_dur.action_({ arg me; var v = me.value.linlin(0,1,0.001,10).postln; x.set(\dur, v.value); n_dur.value = v});
s_spread_dens.action_({ arg me; var v = me.value.linlin(0,1,0,1).postln; x.set(\spread_dens, v.value);});
s_spread_dur.action_({ arg me; var v = me.value.linlin(0,1,0,1).postln; x.set(\spread_dur, v.value);});
s_spread_pan.action_({ arg me; var v = me.value.linlin(0,1,0,1).postln; x.set(\spread_pan, v.value);});


n_dens = GUI.numberBox.new( c3, Rect( 240, 60, 50, 20 )).string_("dens").align_( \center );n_dens.value = 0;
n_dens.action_({arg v; x.set(\dens, v.value); });
n_dur = GUI.numberBox.new( c3, Rect( 240, 190, 50, 20 )).string_("dur").align_( \center );n_dur.value = 0;
n_dur.action_({arg v; x.set(\dur, v.value);});
n_min_dens = GUI.numberBox.new( c3, Rect( 95, 137, 50, 20 )).string_("min dens").align_( \center );n_min_dens.value = 0.1;
n_min_dens.action_({arg v; x.set(\min_dens, v.value);});
n_max_dens = GUI.numberBox.new( c3, Rect( 215, 137, 50, 20 )).string_("max dens").align_( \center );n_max_dens.value = 1;
n_max_dens.action_({arg v; x.set(\max_dens, v.value);});
n_min_dur = GUI.numberBox.new( c3, Rect( 95, 267, 50, 20 )).string_("min dur").align_( \center );n_min_dur.value = 0.01;
n_min_dur.action_({arg v; x.set(\min_dur, v.value);});
n_max_dur = GUI.numberBox.new( c3, Rect( 215, 267, 50, 20 )).string_("max dur").align_( \center );n_max_dur.value = 0.1;
n_max_dur.action_({arg v; x.set(\max_dur, v.value);});
n_trig_dens = GUI.numberBox.new( c3, Rect( 70, 380, 50, 20 )).string_("min dur").align_( \center );n_trig_dens.value = 1;
n_trig_dens.action_({arg v; x.set(\vel_spread_trig_dens, v.value);});
n_trig_dur = GUI.numberBox.new( c3, Rect( 190, 380, 50, 20 )).string_("max dur").align_( \center );n_trig_dur.value = 1;
n_trig_dur.action_({arg v; x.set(\vel_spread_trig_dur, v.value);});

//GRANULATORE GRUPPI CERCHI

b_grain_gruppi = Button(c4, Rect(220,10 ,200 , 20));
b_grain_gruppi.states_([["GRAIN GRUPPI on", Color.red, Color.black],["GRAIN GRUPPI off", Color.black, Color.red]]);
b_grain_gruppi.action_({
	arg me ;
	var val = me.value.postln ;
	if(val == 0){x.set(\grain_gruppi, me.value)}{x.set(\grain_gruppi, me.value)};

});

t_trigA = GUI.staticText.new(c4, Rect(10, 80, 60, 20)).string_("TRIG A").align_( \center );
t_trigA.background = Color.white;
t_trigB = GUI.staticText.new(c4, Rect(10, 275, 60, 20)).string_("TRIG B").align_( \center );
t_trigB.background = Color.white;

n_trigA = GUI.numberBox.new( c4, Rect( 13, 110, 50, 20 )).string_("dens").align_( \center );n_trigA.value = 1;
n_trigA.action_({arg v; x.set(\vel_spread_trigA, v.value); });
n_trigB = GUI.numberBox.new( c4, Rect( 13, 305, 50, 20 )).string_("dens").align_( \center );n_trigB.value = 1;
n_trigB.action_({arg v; x.set(\vel_spread_trigB, v.value); });

t_primo_gruppo = GUI.staticText.new(c4, Rect(10, 35, 60, 40)).string_("PRIMO GRUPPO").align_( \center );
t_primo_gruppo.background = Color.red;

t_secondo_gruppo = GUI.staticText.new(c4, Rect(10, 230, 60, 40)).string_("SECONDO GRUPPO").align_( \center );
t_secondo_gruppo.background = Color.red;

t_dens_cerchio1a = GUI.staticText.new(c4, Rect(80, 35, 60, 30)).string_("dens 1 gruppo A ").align_( \center );
t_dens_cerchio1a.background = Color.white;
t_dur_cerchio1a = GUI.staticText.new(c4, Rect(150, 35, 60, 30)).string_("dur 1 gruppo A ").align_( \center );
t_dur_cerchio1a.background = Color.white;

t_dens_cerchio2a = GUI.staticText.new(c4, Rect(220, 35, 60, 30)).string_("dens 2 gruppo A ").align_( \center );
t_dens_cerchio2a.background = Color.white;
t_dur_cerchio2a = GUI.staticText.new(c4, Rect(290, 35, 60, 30)).string_("dur 2 gruppo A ").align_( \center );
t_dur_cerchio2a.background = Color.white;

t_dens_cerchio3a = GUI.staticText.new(c4, Rect(360, 35, 60, 30)).string_("dens 3 gruppo A ").align_( \center );
t_dens_cerchio3a.background = Color.white;
t_dur_cerchio3a = GUI.staticText.new(c4, Rect(430, 35, 60, 30)).string_("dur 3 gruppo A ").align_( \center );
t_dur_cerchio3a.background = Color.white;

t_dens_cerchio4a = GUI.staticText.new(c4, Rect(80, 100, 60, 30)).string_("dens 4 gruppo A ").align_( \center );
t_dens_cerchio4a.background = Color.white;
t_dur_cerchio4a = GUI.staticText.new(c4, Rect(150, 100, 60, 30)).string_("dur 4 gruppo A ").align_( \center );
t_dur_cerchio4a.background = Color.white;

t_dens_cerchio5a = GUI.staticText.new(c4, Rect(220, 100, 60, 30)).string_("dens 5 gruppo A ").align_( \center );
t_dens_cerchio5a.background = Color.white;
t_dur_cerchio5a = GUI.staticText.new(c4, Rect(290, 100, 60, 30)).string_("dur 5 gruppo A ").align_( \center );
t_dur_cerchio5a.background = Color.white;

t_dens_cerchio6a = GUI.staticText.new(c4, Rect(360, 100, 60, 30)).string_("dens 6 gruppo A ").align_( \center );
t_dens_cerchio6a.background = Color.white;
t_dur_cerchio6a = GUI.staticText.new(c4, Rect(430, 100, 60, 30)).string_("dur 6 gruppo A ").align_( \center );
t_dur_cerchio6a.background = Color.white;

n_dens_cerchio1a = GUI.numberBox.new( c4, Rect( 85, 70, 50, 20 )).string_("dens").align_( \center );n_dens_cerchio1a.value = 1;
n_dens_cerchio1a.action_({arg v; x.set(\dens_cerchio1a, v.value); });
n_dur_cerchio1a = GUI.numberBox.new( c4, Rect( 155, 70, 50, 20 )).string_("dens").align_( \center );n_dur_cerchio1a.value = 0.1;
n_dur_cerchio1a.action_({arg v; x.set(\dur_cerchio1a, v.value); });

n_dens_cerchio2a = GUI.numberBox.new( c4, Rect( 225, 70, 50, 20 )).string_("dens").align_( \center );n_dens_cerchio2a.value = 1;
n_dens_cerchio2a.action_({arg v; x.set(\dens_cerchio2a, v.value); });
n_dur_cerchio2a = GUI.numberBox.new( c4, Rect( 295, 70, 50, 20 )).string_("dens").align_( \center );n_dur_cerchio2a.value = 0.1;
n_dur_cerchio2a.action_({arg v; x.set(\dur_cerchio2a, v.value); });

n_dens_cerchio3a = GUI.numberBox.new( c4, Rect( 365, 70, 50, 20 )).string_("dens").align_( \center );n_dens_cerchio3a.value = 1;
n_dens_cerchio3a.action_({arg v; x.set(\dens_cerchio3a, v.value); });
n_dur_cerchio3a = GUI.numberBox.new( c4, Rect( 435, 70, 50, 20 )).string_("dens").align_( \center );n_dur_cerchio3a.value = 0.1;
n_dur_cerchio3a.action_({arg v; x.set(\dur_cerchio3a, v.value); });

n_dens_cerchio4a = GUI.numberBox.new( c4, Rect( 85, 135, 50, 20 )).string_("dens").align_( \center );n_dens_cerchio4a.value = 1;
n_dens_cerchio4a.action_({arg v; x.set(\dens_cerchio4a, v.value); });
n_dur_cerchio4a = GUI.numberBox.new( c4, Rect( 155, 135, 50, 20 )).string_("dens").align_( \center );n_dur_cerchio4a.value = 0.1;
n_dur_cerchio4a.action_({arg v; x.set(\dur_cerchio4a, v.value); });

n_dens_cerchio5a = GUI.numberBox.new( c4, Rect( 225, 135, 50, 20 )).string_("dens").align_( \center );n_dens_cerchio5a.value = 1;
n_dens_cerchio5a.action_({arg v; x.set(\dens_cerchio5a, v.value); });
n_dur_cerchio5a = GUI.numberBox.new( c4, Rect( 295, 135, 50, 20 )).string_("dens").align_( \center );n_dur_cerchio5a.value = 0.1;
n_dur_cerchio5a.action_({arg v; x.set(\dur_cerchio5a, v.value); });

n_dens_cerchio6a = GUI.numberBox.new( c4, Rect( 365, 135, 50, 20 )).string_("dens").align_( \center );n_dens_cerchio6a.value = 1;
n_dens_cerchio6a.action_({arg v; x.set(\dens_cerchio6a, v.value); });
n_dur_cerchio6a = GUI.numberBox.new( c4, Rect( 435, 135, 50, 20 )).string_("dens").align_( \center );n_dur_cerchio6a.value = 0.1;
n_dur_cerchio6a.action_({arg v; x.set(\dur_cerchio6a, v.value); });


t_dens_cerchio1b = GUI.staticText.new(c4, Rect(80, 230, 60, 30)).string_("dens 1 gruppo B ").align_( \center );
t_dens_cerchio1b.background = Color.white;
t_dur_cerchio1b = GUI.staticText.new(c4, Rect(150, 230, 60, 30)).string_("dur 1 gruppo B ").align_( \center );
t_dur_cerchio1b.background = Color.white;

t_dens_cerchio2b = GUI.staticText.new(c4, Rect(220, 230, 60, 30)).string_("dens 2 gruppo B ").align_( \center );
t_dens_cerchio2b.background = Color.white;
t_dur_cerchio2b = GUI.staticText.new(c4, Rect(290, 230, 60, 30)).string_("dur 2 gruppo B ").align_( \center );
t_dur_cerchio2b.background = Color.white;

t_dens_cerchio3b = GUI.staticText.new(c4, Rect(360, 230, 60, 30)).string_("dens 3 gruppo B ").align_( \center );
t_dens_cerchio3b.background = Color.white;
t_dur_cerchio3b = GUI.staticText.new(c4, Rect(430, 230, 60, 30)).string_("dur 3 gruppo B ").align_( \center );
t_dur_cerchio3b.background = Color.white;

t_dens_cerchio4b = GUI.staticText.new(c4, Rect(80, 300, 60, 30)).string_("dens 4 gruppo B ").align_( \center );
t_dens_cerchio4b.background = Color.white;
t_dur_cerchio4b = GUI.staticText.new(c4, Rect(150, 300, 60, 30)).string_("dur 4 gruppo B ").align_( \center );
t_dur_cerchio4b.background = Color.white;

t_dens_cerchio5b = GUI.staticText.new(c4, Rect(220, 300, 60, 30)).string_("dens 5 gruppo B ").align_( \center );
t_dens_cerchio5b.background = Color.white;
t_dur_cerchio5b = GUI.staticText.new(c4, Rect(290, 300, 60, 30)).string_("dur 5 gruppo B ").align_( \center );
t_dur_cerchio5b.background = Color.white;

t_dens_cerchio6b = GUI.staticText.new(c4, Rect(360, 300, 60, 30)).string_("dens 6 gruppo B ").align_( \center );
t_dens_cerchio6b.background = Color.white;
t_dur_cerchio6b = GUI.staticText.new(c4, Rect(430, 300, 60, 30)).string_("dur 6 gruppo B ").align_( \center );
t_dur_cerchio6b.background = Color.white;

n_dens_cerchio1b = GUI.numberBox.new( c4, Rect( 85, 265, 50, 20 )).string_("dens").align_( \center );n_dens_cerchio1b.value = 1;
n_dens_cerchio1b.action_({arg v; x.set(\dens_cerchio1b, v.value); });
n_dur_cerchio1b = GUI.numberBox.new( c4, Rect( 155, 265, 50, 20 )).string_("dens").align_( \center );n_dur_cerchio1b.value = 0.1;
n_dur_cerchio1b.action_({arg v; x.set(\dur_cerchio1b, v.value); });

n_dens_cerchio2b = GUI.numberBox.new( c4, Rect( 225, 265, 50, 20 )).string_("dens").align_( \center );n_dens_cerchio2b.value = 1;
n_dens_cerchio2b.action_({arg v; x.set(\dens_cerchio2b, v.value); });
n_dur_cerchio2b = GUI.numberBox.new( c4, Rect( 295, 265, 50, 20 )).string_("dens").align_( \center );n_dur_cerchio2b.value = 0.1;
n_dur_cerchio2b.action_({arg v; x.set(\dur_cerchio2b, v.value); });

n_dens_cerchio3b = GUI.numberBox.new( c4, Rect( 365, 265, 50, 20 )).string_("dens").align_( \center );n_dens_cerchio3b.value = 1;
n_dens_cerchio3b.action_({arg v; x.set(\dens_cerchio3b, v.value); });
n_dur_cerchio3b = GUI.numberBox.new( c4, Rect( 435, 265, 50, 20 )).string_("dens").align_( \center );n_dur_cerchio3b.value = 0.1;
n_dur_cerchio3b.action_({arg v; x.set(\dur_cerchio3b, v.value); });

n_dens_cerchio4b = GUI.numberBox.new( c4, Rect( 85, 335, 50, 20 )).string_("dens").align_( \center );n_dens_cerchio4b.value = 1;
n_dens_cerchio4b.action_({arg v; x.set(\dens_cerchio4b, v.value); });
n_dur_cerchio4b = GUI.numberBox.new( c4, Rect( 155, 335, 50, 20 )).string_("dens").align_( \center );n_dur_cerchio4b.value = 0.1;
n_dur_cerchio4b.action_({arg v; x.set(\dur_cerchio4b, v.value); });

n_dens_cerchio5b = GUI.numberBox.new( c4, Rect( 225, 335, 50, 20 )).string_("dens").align_( \center );n_dens_cerchio5b.value = 1;
n_dens_cerchio5b.action_({arg v; x.set(\dens_cerchio5b, v.value); });
n_dur_cerchio5b = GUI.numberBox.new( c4, Rect( 295, 335, 50, 20 )).string_("dens").align_( \center );n_dur_cerchio5b.value = 0.1;
n_dur_cerchio5b.action_({arg v; x.set(\dur_cerchio5b, v.value); });

n_dens_cerchio6b = GUI.numberBox.new( c4, Rect( 365, 335, 50, 20 )).string_("dens").align_( \center );n_dens_cerchio6b.value = 1;
n_dens_cerchio6b.action_({arg v; x.set(\dens_cerchio6b, v.value); });
n_dur_cerchio6b = GUI.numberBox.new( c4, Rect( 435, 335, 50, 20 )).string_("dens").align_( \center );n_dur_cerchio6b.value = 0.1;
n_dur_cerchio6b.action_({arg v; x.set(\dur_cerchio6b, v.value); });




t_spread_densA = GUI.staticText.new(c4, Rect(10, 160, 100, 20)).string_("Spread Dens ").align_( \center );
t_spread_densA.background = Color.white;
t_spread_durA = GUI.staticText.new(c4, Rect(10, 190, 100, 20)).string_("Spread Dur ").align_( \center );
t_spread_durA.background = Color.white;
t_min_spreadA_dens = GUI.staticText.new(c4, Rect(430, 160, 40, 20)).string_("min ").align_( \center );
t_min_spreadA_dens.background = Color.white;
t_max_spreadA_dens = GUI.staticText.new(c4, Rect(530, 160, 40, 20)).string_("max ").align_( \center );
t_max_spreadA_dens.background = Color.white;
t_min_spreadA_dur = GUI.staticText.new(c4, Rect(430, 190, 40, 20)).string_("min ").align_( \center );
t_min_spreadA_dur.background = Color.white;
t_max_spreadA_dur = GUI.staticText.new(c4, Rect(530, 190, 40, 20)).string_("max ").align_( \center );
t_max_spreadA_dur.background = Color.white;

n_min_spreadA_dens = GUI.numberBox.new( c4, Rect( 475, 160, 50, 20 )).string_("dens").align_( \center );
n_min_spreadA_dens.value = 0.1;
n_min_spreadA_dens.action_({arg v; x.set(\min_spreadA_dens, v.value); });
n_max_spreadA_dens = GUI.numberBox.new( c4, Rect( 575, 160, 50, 20 )).string_("dens").align_( \center );
n_max_spreadA_dens.value = 1;
n_max_spreadA_dens.action_({arg v; x.set(\max_spreadA_dens, v.value); });

n_min_spreadA_dur = GUI.numberBox.new( c4, Rect( 475, 190, 50, 20 )).string_("dens").align_( \center );
n_min_spreadA_dur.value = 0.1;
n_min_spreadA_dur.action_({arg v; x.set(\min_spreadA_dur, v.value); });
n_max_spreadA_dur = GUI.numberBox.new( c4, Rect( 575, 190, 50, 20 )).string_("dens").align_( \center );
n_max_spreadA_dur.value = 1;
n_max_spreadA_dur.action_({arg v; x.set(\max_spreadA_dur, v.value); });


s_spread_densA = GUI.slider.new(c4, Rect(120, 160, 300, 20));s_dens.value = 0;
s_spread_densA.action_({ arg me; var v = me.value.linlin(0,1,0,1).postln; x.set(\spread_densA, v.value); });
s_spread_durA = GUI.slider.new(c4, Rect(120, 190, 300, 20));s_dens.value = 0;
s_spread_durA.action_({ arg me; var v = me.value.linlin(0,1,0,1).postln; x.set(\spread_durA, v.value); });






t_spread_densB = GUI.staticText.new(c4, Rect(10, 365, 100, 20)).string_("Spread Dens ").align_( \center );
t_spread_densB.background = Color.white;
t_spread_durB = GUI.staticText.new(c4, Rect(10, 395, 100, 20)).string_("Spread Dur ").align_( \center );
t_spread_durB.background = Color.white;
t_min_spreadB_dens = GUI.staticText.new(c4, Rect(430, 365, 40, 20)).string_("min ").align_( \center );
t_min_spreadB_dens.background = Color.white;
t_max_spreadB_dens = GUI.staticText.new(c4, Rect(530, 365, 40, 20)).string_("max ").align_( \center );
t_max_spreadB_dens.background = Color.white;
t_min_spreadB_dur = GUI.staticText.new(c4, Rect(430, 395, 40, 20)).string_("min ").align_( \center );
t_min_spreadB_dur.background = Color.white;
t_max_spreadB_dur = GUI.staticText.new(c4, Rect(530, 395, 40, 20)).string_("max ").align_( \center );
t_max_spreadB_dur.background = Color.white;

n_min_spreadB_dens = GUI.numberBox.new( c4, Rect( 475, 365, 50, 20 )).string_("dens").align_( \center );
n_min_spreadB_dens.value = 0.1;
n_min_spreadB_dens.action_({arg v; x.set(\min_spreadB_dens, v.value); });
n_max_spreadB_dens = GUI.numberBox.new( c4, Rect( 575, 365, 50, 20 )).string_("dens").align_( \center );
n_max_spreadB_dens.value = 1;
n_max_spreadB_dens.action_({arg v; x.set(\max_spreadB_dens, v.value); });

n_min_spreadB_dur = GUI.numberBox.new( c4, Rect( 475, 395, 50, 20 )).string_("dens").align_( \center );
n_min_spreadB_dur.value = 0.1;
n_min_spreadB_dur.action_({arg v; x.set(\min_spreadB_dur, v.value); });
n_max_spreadB_dur = GUI.numberBox.new( c4, Rect( 575, 395, 50, 20 )).string_("dens").align_( \center );
n_max_spreadB_dur.value = 1;
n_max_spreadB_dur.action_({arg v; x.set(\max_spreadB_dur, v.value); });

s_spread_densB = GUI.slider.new(c4, Rect(120, 365, 300, 20));s_dens.value = 0;
s_spread_densB.action_({ arg me; var v = me.value.linlin(0,1,0,1).postln; x.set(\spread_densB, v.value); });
s_spread_durB = GUI.slider.new(c4, Rect(120, 395, 300, 20));s_dens.value = 0;
s_spread_durB.action_({ arg me; var v = me.value.linlin(0,1,0,1).postln; x.set(\spread_durB, v.value); });

k_spread_panA = GUI.knob.new(c4, Rect(525, 80, 60, 60)); k_spread_panA.value = 0;
k_spread_panA.action_({ arg me; var v = me.value.linlin(0, 1, 0, 1).postln; x.set(\spread_panA, v); });
t_spread_panA = GUI.staticText.new(c4, Rect(510, 35, 100, 20)).string_("Spread Pan ").align_( \center );
t_spread_panA.background = Color.white;
k_spread_panB = GUI.knob.new(c4, Rect(525, 275, 60, 60)); k_spread_panB.value = 0;
k_spread_panB.action_({ arg me; var v = me.value.linlin(0, 1, 0, 1).postln; x.set(\spread_panB, v); });
t_spread_panB = GUI.staticText.new(c4, Rect(510, 230, 100, 20)).string_("Spread Pan ").align_( \center );
t_spread_panB.background = Color.white;


//MODULATORE CICLOIDI

b_grain_cicloidi = Button(c5, Rect(120,10,200,20));
b_grain_cicloidi.states_([["GRAIN CICLOIDI on", Color.red, Color.black],["GRAIN CICLOIDI off", Color.black, Color.red]]);
b_grain_cicloidi.action_({
	arg me ;
	var val = me.value.postln ;
	if(val == 0){x.set(\grain_cicloidi, me.value)}{x.set(\grain_cicloidi, me.value)};

});

k_vel_cicloide1a = GUI.knob.new(c5, Rect(95, 65, 50, 50)); k_vel_cicloide1a.value = 0;
k_vel_cicloide1a.action_({ arg me; var v = me.value.linlin(0, 1, 0, 1).postln; x.set(\vel_cicloide1a, v); });
k_vel_cicloide2a = GUI.knob.new(c5, Rect(95, 125, 50, 50)); k_vel_cicloide2a.value = 0;
k_vel_cicloide2a.action_({ arg me; var v = me.value.linlin(0, 1, 0, 1).postln; x.set(\vel_cicloide2a, v); });
k_vel_cicloide3a = GUI.knob.new(c5, Rect(95, 185, 50, 50)); k_vel_cicloide3a.value = 0;
k_vel_cicloide3a.action_({ arg me; var v = me.value.linlin(0, 1, 0, 1).postln; x.set(\vel_cicloide3a, v); });
k_vel_cicloide4a = GUI.knob.new(c5, Rect(95, 245, 50, 50)); k_vel_cicloide4a.value = 0;
k_vel_cicloide4a.action_({ arg me; var v = me.value.linlin(0, 1, 0, 1).postln; x.set(\vel_cicloide4a, v); });
k_vel_cicloide5a = GUI.knob.new(c5, Rect(95, 305, 50, 50)); k_vel_cicloide5a.value = 0;
k_vel_cicloide5a.action_({ arg me; var v = me.value.linlin(0, 1, 0, 1).postln; x.set(\vel_cicloide5a, v); });
k_vel_cicloide6a = GUI.knob.new(c5, Rect(95, 365, 50, 50)); k_vel_cicloide6a.value = 0;
k_vel_cicloide6a.action_({ arg me; var v = me.value.linlin(0, 1, 0, 1).postln; x.set(\vel_cicloide6a, v); });

k_vel_cicloide1b = GUI.knob.new(c5, Rect(255, 65, 50, 50)); k_vel_cicloide1b.value = 0;
k_vel_cicloide1b.action_({ arg me; var v = me.value.linlin(0, 1, 0, 1).postln; x.set(\vel_cicloide1b, v); });
k_vel_cicloide2b = GUI.knob.new(c5, Rect(255, 125, 50, 50)); k_vel_cicloide2b.value = 0;
k_vel_cicloide2b.action_({ arg me; var v = me.value.linlin(0, 1, 0, 1).postln; x.set(\vel_cicloide2b, v); });
k_vel_cicloide3b = GUI.knob.new(c5, Rect(255, 185, 50, 50)); k_vel_cicloide3b.value = 0;
k_vel_cicloide3b.action_({ arg me; var v = me.value.linlin(0, 1, 0, 1).postln; x.set(\vel_cicloide3b, v); });
k_vel_cicloide4b = GUI.knob.new(c5, Rect(255, 245, 50, 50)); k_vel_cicloide4b.value = 0;
k_vel_cicloide4b.action_({ arg me; var v = me.value.linlin(0, 1, 0, 1).postln; x.set(\vel_cicloide4b, v); });
k_vel_cicloide5b = GUI.knob.new(c5, Rect(255, 305, 50, 50)); k_vel_cicloide5b.value = 0;
k_vel_cicloide5b.action_({ arg me; var v = me.value.linlin(0, 1, 0, 1).postln; x.set(\vel_cicloide5b, v); });
k_vel_cicloide6b = GUI.knob.new(c5, Rect(255, 365, 50, 50)); k_vel_cicloide6b.value = 0;
k_vel_cicloide6b.action_({ arg me; var v = me.value.linlin(0, 1, 0, 1).postln; x.set(\vel_cicloide6b, v); });


t_cicloidi_gruppoA = GUI.staticText.new(c5, Rect(70, 40, 100, 20)).string_("Cicloidi A ").align_( \center );
t_cicloidi_gruppoA.background = Color.red;
t_cicloidi_gruppoB = GUI.staticText.new(c5, Rect(230, 40, 100, 20)).string_("Cicloidi B ").align_( \center );
t_cicloidi_gruppoB.background = Color.red;

t_vel1 = GUI.staticText.new(c5, Rect(20, 80, 50, 20)).string_("Vel 1 ").align_( \center );
t_vel1.background = Color.red;
t_vel2 = GUI.staticText.new(c5, Rect(20, 140, 50, 20)).string_("Vel 2 ").align_( \center );
t_vel2.background = Color.red;
t_vel3 = GUI.staticText.new(c5, Rect(20, 200, 50, 20)).string_("Vel 3 ").align_( \center );
t_vel3.background = Color.red;
t_vel4 = GUI.staticText.new(c5, Rect(20, 260, 50, 20)).string_("Vel 4 ").align_( \center );
t_vel4.background = Color.red;
t_vel5 = GUI.staticText.new(c5, Rect(20, 320, 50, 20)).string_("Vel 5 ").align_( \center );
t_vel5.background = Color.red;
t_vel6 = GUI.staticText.new(c5, Rect(20, 380, 50, 20)).string_("Vel 6 ").align_( \center );
t_vel6.background = Color.red;

)

s.freqscope

(
// SYNTHDEF

SynthDef.new(\metatron, {arg outbus,

	//volume finale
	volume = 0,
	//frequenza generatrice
	fond = 20,
    //controlli per la riverberazione
	mix = 0, room = 0, damp = 0.5,
	//parametri generali relativi ai delay per lo spostamento di fase
	maxdelay = 10, pfond = 0, afond = 1, amp_a1 = (3/5),
	//velocità di spostastamento dei cerchi nei gruppi A e B
	vel_ampA = 0.5, vel_phaseA = 0.5, vel_ampB = 0.5,vel_phaseB = 0.5,
	//controlli relativi
	vel_trig = 1, min_freq = 40, max_freq = 200,
	//controlli relativi allo spred frequenziale al generatore
	sel_gen0 = 0,sel_gen1 = 1, spread_freq = 20, vel_trig_spread = 1, spread_amp = 0,
	//controllo in ampiezza dei cerchi fondamentali
	cerchio_amp1 = 1,cerchio_amp2 = 1,cerchio_amp3 = 1,cerchio_amp4 = 1,cerchio_amp5 = 1,
	//controllo in ampiezza dei gruppi
	cerchi_gruppoA = 1, cerchi_gruppoB = 1,
	//controllo in ampiezza dei cicloidi
	cicloidiA = 1, cicloidiB = 1,
	//parametri iniziali relativi alla granulazione dei cerchi fondamentali
	dens = 1,dur = 0.1,maxgrain = 512,pan = 0,grain_cerchi = 0,
	//spread dens e dur relativi alla granulazione dei cerchi fondamentali
	spread_dens = 0, min_dens = 0.1,max_dens = 1,vel_spread_trig_dens = 1,vel_spread_trig_dur = 1,spread_dur = 0, min_dur = 0.1, max_dur = 1,
	// spread pan relativo alla granulazione dei cerchi principali
	spread_pan = 0,
	//on off grain gruppi
	grain_gruppi = 0,
    //controlli relativi allo spread grain gruppo A
    vel_spread_trigA = 1,min_spreadA_dens = 0.1,max_spreadA_dens = 1,spread_densA = 0,min_spreadA_dur = 0.1,max_spreadA_dur = 1,spread_durA = 0,spread_panA,
   //controlli relativi ala granulazione di ogni cerchio nel gruppo A
	dens_cerchio1a = 1,dens_cerchio2a = 1,dens_cerchio3a = 1,dens_cerchio4a = 1,dens_cerchio5a = 1,dens_cerchio6a = 1,dur_cerchio1a = 0.1,dur_cerchio2a = 0.1,dur_cerchio3a = 0.1,dur_cerchio4a = 0.1,dur_cerchio5a = 0.1,dur_cerchio6a = 0.1,
    //controlli relativi allo spread grain gruppo B
    vel_spread_trigB = 1,min_spreadB_dens = 0.1,max_spreadB_dens = 1,spread_densB = 0,min_spreadB_dur = 0.1,max_spreadB_dur = 1,spread_durB = 0, spread_panB,
   //controlli relativi ala granulazione di ogni cerchio nel gruppo B
	dens_cerchio1b = 1,dens_cerchio2b = 1,dens_cerchio3b = 1,dens_cerchio4b = 1,dens_cerchio5b = 1,dens_cerchio6b = 1,dur_cerchio1b = 0.1,dur_cerchio2b = 0.1,dur_cerchio3b = 0.1,dur_cerchio4b = 0.1,dur_cerchio5b = 0.1,dur_cerchio6b = 0.1,
    //controlli velocità cicloidi gruppo A
	vel_cicloide1a = 0,vel_cicloide2a = 0,vel_cicloide3a = 0,vel_cicloide4a = 0,vel_cicloide5a = 0,vel_cicloide6a = 0,
    //controlli velocità cicloidi gruppo A
	vel_cicloide1b 	= 0,vel_cicloide2b = 0,vel_cicloide3b = 0,vel_cicloide4b = 0,vel_cicloide5b = 0,vel_cicloide6b = 0;



	var t, signal,
    //variabili di delay e di uscita dei cerchi principali
	cerchio1, cerchio2, delay_cerchio2, cerchio3, delay_cerchio3, cerchio4, delay_cerchio4, cerchio5, delay_cerchio5,
    //variabili di uscita dei gruppi
	cerchio5_a1, cerchio5_a2, cerchio5_a3, cerchio5_a4, cerchio5_a5, cerchio5_a6, cerchio5_b1, cerchio5_b2, cerchio5_b3, cerchio5_b4, cerchio5_b5, cerchio5_b6,
    //variabili di  uscita dalla somma dei cerchi fondamentali e dai gruppi
	cerchi_fondamentali, cerchi_phase_modA, cerchi_phase_modB,
    //calcolo dei cicloidi
	circonferenza,  raggio, semicorda, saetta, raggio_cerchio_cicloide, diametro, freq_cicloide,
    //variabili di uscita dei cicloidi gruppo A
	cicloide_1_a, cicloide_2_a, cicloide_3_a, cicloide_4_a, cicloide_5_a, cicloide_6_a,
    //variabili di uscita della sommatoria cicloidi gruppo A
	cicloidi_gruppo_A,
    //variabili di uscita dei cicloidi gruppo B
	cicloide_1_b1, cicloide_1_b2, cicloide_1_b3, cicloide_2_b1, cicloide_2_b2, cicloide_2_b3, cicloide_3_b1, cicloide_3_b2, cicloide_3_b3, cicloide_4_b1, cicloide_4_b2, cicloide_4_b3, cicloide_5_b1, cicloide_5_b2, cicloide_5_b3, cicloide_6_b1,cicloide_6_b2,cicloide_6_b3,
    //variabili di uscita della sommatoria cicloidi gruppo B
	cicloidi_gruppo_B,
    //variabili per i vari trigger
	trig,ffond,trig2,spread0,spread,
    //variabili di uscita dei cerchi fondamentali
	cerchio1_0,cerchio2_0,cerchio3_0,cerchio4_0,cerchio5_0,
    //variabili di uscita dei gruppi
	cerchi_gruppoA0,cerchi_gruppoB0,
    //variabili di uscita dei cicloidi
	cicloidiA0,cicloidiB0,
    //variabili di uscita dei granulatori relativi ai cerchi fondamentali
	grain_cerchio1,grain_cerchio2,grain_cerchio3,grain_cerchio4,grain_cerchio5,
    //variabili di uscita al modulatore per i cicloidi A
	mod_cicloide1a,mod_cicloide2a,mod_cicloide3a,mod_cicloide4a,mod_cicloide5a,mod_cicloide6a,
	 //variabili di uscita al modulatore per i cicloidi B
	mod_cicloide1b,mod_cicloide2b,mod_cicloide3b,mod_cicloide4b,mod_cicloide5b,mod_cicloide6b,
    //variabili per lo spread dur e dens relativi ai cerchi fondamentali
	denspread,trig_spread_dens,trig_spread_dur,durspread,
    //variabili relativi allo spread pan dei cerchi fondamentali
	panspread1,panspread2,panspread3,panspread4,panspread5,trig_pan,
    //variabili in uscita dei granulatori del gruppo A
	grain_gruppo1A,grain_gruppo2A,grain_gruppo3A,grain_gruppo4A,grain_gruppo5A,grain_gruppo6A,grain_gruppoA,
	//variabili in uscita dei granulatori del gruppo B
	grain_gruppo1B,grain_gruppo2B,grain_gruppo3B,grain_gruppo4B,grain_gruppo5B,grain_gruppo6B,grain_gruppoB,
    //variabili  per lo spread gruppo A
	trig_spread_dens_gruppoA,trig_spread_dur_gruppoA,denspread_gruppoA,durspread_gruppoA,trig_panA,panspreadA,
    //variabili  per lo spread gruppo B
	trig_spread_dens_gruppoB,trig_spread_dur_gruppoB,denspread_gruppoB,durspread_gruppoB,trig_panB,panspreadB;


//generatore frequenza fondamentale

	 trig = Dust.kr(vel_trig);
	trig2 = Dust.kr(vel_trig_spread);

    spread0 = TRand.kr((0-(spread_freq/2)), (spread_freq/2), trig2);
	spread = spread0*spread_amp;

	ffond =( (TRand.kr(min_freq,max_freq,trig))*(sel_gen0))+((fond+spread)*(sel_gen1));


	//generazione dei dati per la granutalzione ai cerchi fondamentali

	trig_spread_dens = Dust.kr(vel_spread_trig_dens);
    trig_spread_dur = Dust.kr(vel_spread_trig_dur);
	trig_pan = Dust.kr(10);


	denspread = (TRand.kr(min_dens,max_dens,trig_spread_dens))*spread_dens;
    durspread = (TRand.kr(min_dur,max_dur,trig_spread_dur))*spread_dur;
	panspread1 = (TRand.kr(-1,1,trig_pan*0.1))*spread_pan;
    panspread2 = (TRand.kr(-1,1,trig_pan*0.2))*spread_pan;
	panspread3 = (TRand.kr(-1,1,trig_pan*0.3))*spread_pan;
	panspread4 = (TRand.kr(-1,1,trig_pan*0.4))*spread_pan;
	panspread5 = (TRand.kr(-1,1,trig_pan*0.5))*spread_pan;


	//generazione dei dati per la granulazione dei cerchi del gruppo A

	trig_spread_dens_gruppoA = Dust.kr(vel_spread_trigA);
    trig_spread_dur_gruppoA = Dust.kr(vel_spread_trigA);
	trig_panA = Dust.kr(10);

	denspread_gruppoA = (TRand.kr(min_spreadA_dens,max_spreadA_dens,trig_spread_dens_gruppoA))*spread_densA;
	durspread_gruppoA = (TRand.kr(min_spreadA_dens,max_spreadA_dur,trig_spread_dur_gruppoA))*spread_durA;
    panspreadA = (TRand.kr(-1,1,trig_panA))*spread_panA;

	//generazione dei dati per la granulazione dei cerchi del gruppo B

    trig_spread_dens_gruppoB = Dust.kr(vel_spread_trigB);
    trig_spread_dur_gruppoB = Dust.kr(vel_spread_trigB);
    trig_panB = Dust.kr(10);

	denspread_gruppoB = (TRand.kr(min_spreadB_dens,max_spreadB_dens,trig_spread_dens_gruppoB))*spread_densB;
	durspread_gruppoB = (TRand.kr(min_spreadB_dens,max_spreadB_dur,trig_spread_dur_gruppoB))*spread_durB;
    panspreadB = (TRand.kr(-1,1,trig_panB))*spread_panB;

//calcolo del tempo di inizio e fine ciclo delle sinusoide fondamentali
t = 1/ffond;


//cerchi fondamentali
cerchio1_0 = (Pan2.ar(SinOsc.ar(ffond*(5/5),pfond,afond*(5/5))));

	grain_cerchio1 =  GrainIn.ar(2,Dust.kr((dens*(5/5))+denspread),(dur*(5/5))+durspread,cerchio1_0,panspread1,-1,maxgrain,grain_cerchi);

	cerchio1 = (cerchio1_0*cerchio_amp1)+((grain_cerchio1)*(1-cerchio_amp1));


delay_cerchio2 = t*(1/20);//calcolo del ritardo "fase"
cerchio2_0 = (Pan2.ar(DelayN.ar(SinOsc.ar(ffond*(5/4),0,afond*(4/5)),maxdelay,delay_cerchio2)));

	grain_cerchio2 =  GrainIn.ar(2,Dust.kr((dens*(5/4))+denspread),(dur*(4/5))+durspread,cerchio2_0,panspread2,-1,maxgrain,grain_cerchi);

	cerchio2 = (cerchio2_0*cerchio_amp2)+((grain_cerchio2)*(1-cerchio_amp2));


delay_cerchio3 = t*(2/20);
cerchio3_0 = (Pan2.ar(DelayN.ar(SinOsc.ar(ffond*(5/3),0,afond*(3/5)),maxdelay,delay_cerchio3)));

	grain_cerchio3 =  GrainIn.ar(2,Dust.kr((dens*(5/3))+denspread),(dur*(3/5))+durspread,cerchio3_0,panspread3,-1,maxgrain,grain_cerchi);

	cerchio3 = (cerchio3_0*cerchio_amp3)+((grain_cerchio3)*(1-cerchio_amp3));

delay_cerchio4 = t*(3/20);
cerchio4_0 = (Pan2.ar(DelayN.ar(SinOsc.ar(ffond*(5/2),0,afond*(2/5)),maxdelay,delay_cerchio4)));

	grain_cerchio4 =  GrainIn.ar(2,Dust.kr((dens*(5/2))+denspread),(dur*(2/5))+durspread,cerchio4_0,panspread4,-1,maxgrain,grain_cerchi);

	cerchio4 = (cerchio4_0*cerchio_amp4)+((grain_cerchio4)*(1-cerchio_amp4));


delay_cerchio5 = t*(4/20);
cerchio5_0 = (Pan2.ar(DelayN.ar(SinOsc.ar(ffond*(5/1),0,afond*(1/5)),maxdelay,delay_cerchio5)));
cerchio5 = cerchio5_0*cerchio_amp5;

	grain_cerchio5 =  GrainIn.ar(2,Dust.kr((dens*(5/1))+denspread),(dur*(1/5))+durspread,cerchio5_0,panspread5,-1,maxgrain,grain_cerchi);

	cerchio5 = (cerchio5_0*cerchio_amp5)+((grain_cerchio5)*(1-cerchio_amp5));


cerchi_fondamentali = (cerchio1+cerchio2+cerchio3+cerchio4+cerchio5)/5;



	//cerchi con fase modulata relativi al cerchio5

	//cerchi A

	cerchio5_a1 = (Pan2.ar(DelayN.ar(SinOsc.ar(ffond*(5/1), SinOsc.kr(vel_phaseA, 0, pi), SinOsc.kr(vel_ampA, pi/2, afond*(3/5))),maxdelay,delay_cerchio5)));

	cerchio5_a2 = (Pan2.ar(DelayN.ar(SinOsc.ar(ffond*(5/1), SinOsc.kr(vel_phaseA, pi/3, pi), SinOsc.kr(vel_ampA, pi*(5/6), afond*(3/5)) ),maxdelay,delay_cerchio5)));

	cerchio5_a3 = (Pan2.ar(DelayN.ar(SinOsc.ar(ffond*(5/1), SinOsc.kr(vel_phaseA, pi/3, pi), SinOsc.kr(vel_ampA, pi*(7/6), afond*(3/5) )),maxdelay,delay_cerchio5)));

	cerchio5_a4 = (Pan2.ar(DelayN.ar(SinOsc.ar(ffond*(5/1), SinOsc.kr(vel_phaseA, 0, -pi), SinOsc.kr(vel_ampA, pi*(3/2), afond*(3/5) )),maxdelay,delay_cerchio5)));

	cerchio5_a5 = (Pan2.ar(DelayN.ar(SinOsc.ar(ffond*(5/1), SinOsc.kr(vel_phaseA, pi/3, -pi), SinOsc.kr(vel_ampA, pi*(11/6),
afond*(3/5))),maxdelay,delay_cerchio5)));

	cerchio5_a6 = (Pan2.ar(DelayN.ar(SinOsc.ar(ffond*(5/1), SinOsc.kr(vel_phaseA, pi/3, -pi), SinOsc.kr(vel_ampA, pi/6, afond*(3/5))),maxdelay,delay_cerchio5)));



	grain_gruppo1A = GrainIn.ar(2,Dust.kr(dens_cerchio1a+denspread_gruppoA),dur_cerchio1a+durspread_gruppoA,cerchio5_a1,panspreadA,-1,maxgrain,grain_gruppi);
    grain_gruppo2A = GrainIn.ar(2,Dust.kr(dens_cerchio2a+denspread_gruppoA),dur_cerchio2a+durspread_gruppoA,cerchio5_a2,panspreadA,-1,maxgrain,grain_gruppi);
	grain_gruppo3A = GrainIn.ar(2,Dust.kr(dens_cerchio3a+denspread_gruppoA),dur_cerchio3a+durspread_gruppoA,cerchio5_a3,panspreadA,-1,maxgrain,grain_gruppi);
	grain_gruppo4A = GrainIn.ar(2,Dust.kr(dens_cerchio4a+denspread_gruppoA),dur_cerchio4a+durspread_gruppoA,cerchio5_a4,panspreadA,-1,maxgrain,grain_gruppi);
	grain_gruppo5A = GrainIn.ar(2,Dust.kr(dens_cerchio5a+denspread_gruppoA),dur_cerchio5a+durspread_gruppoA,cerchio5_a5,panspreadA,-1,maxgrain,grain_gruppi);
	grain_gruppo6A = GrainIn.ar(2,Dust.kr(dens_cerchio6a+denspread_gruppoA),dur_cerchio6a+durspread_gruppoA,cerchio5_a6,panspreadA,-1,maxgrain,grain_gruppi);


	grain_gruppoA = (grain_gruppo1A+grain_gruppo2A+grain_gruppo3A+grain_gruppo4A+grain_gruppo5A+grain_gruppo6A)/6;
	cerchi_gruppoA0 = (cerchio5_a1 + cerchio5_a2 + cerchio5_a3 + cerchio5_a4 + cerchio5_a5 + cerchio5_a6 )/6;

	cerchi_phase_modA = (cerchi_gruppoA0*cerchi_gruppoA)+(grain_gruppoA*(1-cerchi_gruppoA));

	//cerchi B

	cerchio5_b1 = (Pan2.ar(DelayN.ar(SinOsc.ar(ffond*(5/1), SinOsc.kr(vel_phaseB, 0,2* pi), SinOsc.kr(vel_ampB, pi/2, afond*(5/5))),maxdelay,delay_cerchio5)));

    cerchio5_b2 = (Pan2.ar(DelayN.ar(SinOsc.ar(ffond*(5/1), SinOsc.kr(vel_phaseB, pi/3,2* pi), SinOsc.kr(vel_ampB, pi*(5/6), afond*(5/5)) ),maxdelay,delay_cerchio5)));

	cerchio5_b3 = (Pan2.ar(DelayN.ar(SinOsc.ar(ffond*(5/1), SinOsc.kr(vel_phaseB, pi/3,2* pi), SinOsc.kr(vel_ampB, pi*(7/6), afond*(5/5) )),maxdelay,delay_cerchio5)));

	cerchio5_b4 = (Pan2.ar(DelayN.ar(SinOsc.ar(ffond*(5/1), SinOsc.kr(vel_phaseB, 0, -2*pi), SinOsc.kr(vel_ampB, pi*(3/2), afond*(5/5) )),maxdelay,delay_cerchio5)));

	cerchio5_b5 = (Pan2.ar(DelayN.ar(SinOsc.ar(ffond*(5/1), SinOsc.kr(vel_phaseB, pi/3, -2*pi), SinOsc.kr(vel_ampB, pi*(11/6),
afond*(5/5))),maxdelay,delay_cerchio5)));

	cerchio5_b6 = (Pan2.ar(DelayN.ar(SinOsc.ar(ffond*(5/1), SinOsc.kr(vel_phaseB, pi/3, -2*pi), SinOsc.kr(vel_ampB, pi/6, afond*(5/5))),maxdelay,delay_cerchio5)));


		grain_gruppo1B = GrainIn.ar(2,Dust.kr(dens_cerchio1b+denspread_gruppoB),dur_cerchio1b+durspread_gruppoB,cerchio5_b1,panspreadB,-1,maxgrain,grain_gruppi);
    grain_gruppo2B = GrainIn.ar(2,Dust.kr(dens_cerchio2b+denspread_gruppoB),dur_cerchio2b+durspread_gruppoB,cerchio5_b2,panspreadB,-1,maxgrain,grain_gruppi);
	grain_gruppo3B = GrainIn.ar(2,Dust.kr(dens_cerchio3b+denspread_gruppoB),dur_cerchio3b+durspread_gruppoB,cerchio5_b3,panspreadB,-1,maxgrain,grain_gruppi);
	grain_gruppo4B = GrainIn.ar(2,Dust.kr(dens_cerchio4b+denspread_gruppoB),dur_cerchio4b+durspread_gruppoB,cerchio5_b4,panspreadB,-1,maxgrain,grain_gruppi);
	grain_gruppo5B = GrainIn.ar(2,Dust.kr(dens_cerchio5b+denspread_gruppoB),dur_cerchio5b+durspread_gruppoB,cerchio5_b5,panspreadB,-1,maxgrain,grain_gruppi);
	grain_gruppo6B = GrainIn.ar(2,Dust.kr(dens_cerchio6b+denspread_gruppoB),dur_cerchio6b+durspread_gruppoB,cerchio5_b6,panspreadB,-1,maxgrain,grain_gruppi);


	grain_gruppoB = (grain_gruppo1B+grain_gruppo2B+grain_gruppo3B+grain_gruppo4B+grain_gruppo5B+grain_gruppo6B)/6;
    cerchi_gruppoB0 = (cerchio5_b1 + cerchio5_b2 + cerchio5_b3 + cerchio5_b4 + cerchio5_b5 + cerchio5_b6 )/6;

	cerchi_phase_modB = (cerchi_gruppoB0*cerchi_gruppoB)+(grain_gruppoB*(1-cerchi_gruppoB));


	//calcolo del raggio del nuovo cerchio formato dalla cicloide

	diametro = 1/5;

	circonferenza = pi*diametro;

	circonferenza.postln;

	semicorda = circonferenza/2;

	saetta = 1/5;

	raggio_cerchio_cicloide = ((semicorda*semicorda)+ (saetta*saetta))/(2*saetta);

	raggio_cerchio_cicloide.postln;

    freq_cicloide = raggio_cerchio_cicloide*10;

	freq_cicloide.postln;


	//Formazione cicloidi gruppo A

	mod_cicloide1a = SinOsc.kr(1*vel_cicloide1a);
    mod_cicloide2a = SinOsc.kr(2*vel_cicloide2a);
	mod_cicloide3a = SinOsc.kr(3*vel_cicloide3a);
	mod_cicloide4a = SinOsc.kr(4*vel_cicloide4a);
	mod_cicloide5a = SinOsc.kr(5*vel_cicloide5a);
	mod_cicloide6a = SinOsc.kr(6*vel_cicloide6a);

	cicloide_1_a = (Pan2.ar(DelayN.ar(SinOsc.ar(ffond*freq_cicloide, pi/2,afond*raggio_cerchio_cicloide),maxdelay,delay_cerchio5),mod_cicloide1a));

    cicloide_2_a = (Pan2.ar(DelayN.ar(SinOsc.ar(ffond*freq_cicloide, pi*(5/6),afond*raggio_cerchio_cicloide),maxdelay,delay_cerchio5),mod_cicloide2a));

	cicloide_3_a = (Pan2.ar(DelayN.ar(SinOsc.ar(ffond*freq_cicloide, pi*(7/6),afond*raggio_cerchio_cicloide),maxdelay,delay_cerchio5),mod_cicloide3a));

	cicloide_4_a = (Pan2.ar(DelayN.ar(SinOsc.ar(ffond*freq_cicloide, pi*(3/2),afond*raggio_cerchio_cicloide),maxdelay,delay_cerchio5),mod_cicloide4a));

	cicloide_5_a = (Pan2.ar(DelayN.ar(SinOsc.ar(ffond*freq_cicloide, pi*(11/6),afond*raggio_cerchio_cicloide),maxdelay,delay_cerchio5),mod_cicloide5a));

	cicloide_6_a = (Pan2.ar(DelayN.ar(SinOsc.ar(ffond*(freq_cicloide), pi/6,afond*raggio_cerchio_cicloide),maxdelay,delay_cerchio5),mod_cicloide6a));



	cicloidiA0 = (cicloide_1_a + cicloide_2_a + cicloide_3_a + cicloide_4_a + cicloide_5_a + cicloide_6_a)/6;

   cicloidi_gruppo_A = cicloidiA0*cicloidiA;

	//Formazione cicloidi gruppo B


	mod_cicloide1b = SinOsc.kr(7*vel_cicloide1b);
    mod_cicloide2b = SinOsc.kr(8*vel_cicloide2b);
	mod_cicloide3b = SinOsc.kr(9*vel_cicloide3b);
	mod_cicloide4b = SinOsc.kr(10*vel_cicloide4b);
	mod_cicloide5b = SinOsc.kr(11*vel_cicloide5b);
	mod_cicloide6b = SinOsc.kr(12*vel_cicloide6b);

	cicloide_1_b1 = (Pan2.ar(DelayN.ar(SinOsc.ar(ffond*freq_cicloide*2, pi/2,(afond*raggio_cerchio_cicloide)),maxdelay,delay_cerchio5),mod_cicloide1b));
	cicloide_1_b2 = (Pan2.ar(DelayN.ar(SinOsc.ar(ffond*freq_cicloide*2, pi*(7/6),(afond*raggio_cerchio_cicloide)),maxdelay,delay_cerchio5),mod_cicloide2b));
	cicloide_1_b3 = (Pan2.ar(DelayN.ar(SinOsc.ar(ffond*freq_cicloide*2, pi*(11/6),(afond*raggio_cerchio_cicloide)),maxdelay,delay_cerchio5),mod_cicloide3b));

	cicloide_2_b1 = (Pan2.ar(DelayN.ar(SinOsc.ar(ffond*freq_cicloide*2, pi*(5/6),(afond*raggio_cerchio_cicloide)),maxdelay,delay_cerchio5), mod_cicloide4b));
	cicloide_2_b2 = (Pan2.ar(DelayN.ar(SinOsc.ar(ffond*freq_cicloide*2, pi*(3/2),(afond*raggio_cerchio_cicloide)),maxdelay,delay_cerchio5), mod_cicloide5b));
	cicloide_2_b3 = (Pan2.ar(DelayN.ar(SinOsc.ar(ffond*freq_cicloide*2, pi/6,(afond*raggio_cerchio_cicloide)),maxdelay,delay_cerchio5), mod_cicloide6b));

	cicloide_3_b1 = (Pan2.ar(DelayN.ar(SinOsc.ar(ffond*freq_cicloide*3, pi*(7/6),(afond*raggio_cerchio_cicloide)),maxdelay,delay_cerchio5),mod_cicloide1b));
	cicloide_3_b2 = (Pan2.ar(DelayN.ar(SinOsc.ar(ffond*freq_cicloide*3, pi*(11/6),(afond*raggio_cerchio_cicloide)),maxdelay,delay_cerchio5),mod_cicloide2b));
	cicloide_3_b3 = (Pan2.ar(DelayN.ar(SinOsc.ar(ffond*freq_cicloide*3, pi/2,(afond*raggio_cerchio_cicloide)),maxdelay,delay_cerchio5),mod_cicloide3b));

	cicloide_4_b1 = (Pan2.ar(DelayN.ar(SinOsc.ar(ffond*freq_cicloide*3, pi*(3/2),(afond*raggio_cerchio_cicloide)),maxdelay,delay_cerchio5),mod_cicloide4b));
	cicloide_4_b2 = (Pan2.ar(DelayN.ar(SinOsc.ar(ffond*freq_cicloide*3, pi/6,(afond*raggio_cerchio_cicloide)),maxdelay,delay_cerchio5),mod_cicloide5b));
	cicloide_4_b3 = (Pan2.ar(DelayN.ar(SinOsc.ar(ffond*freq_cicloide*3, pi*(5/6),(afond*raggio_cerchio_cicloide)),maxdelay,delay_cerchio5),mod_cicloide6b));

	cicloide_5_b1 = (Pan2.ar(DelayN.ar(SinOsc.ar(ffond*freq_cicloide*13, pi*(11/6),(afond*raggio_cerchio_cicloide)),maxdelay,delay_cerchio5),mod_cicloide1b));
	cicloide_5_b2 = (Pan2.ar(DelayN.ar(SinOsc.ar(ffond*freq_cicloide*13, pi/2,(afond*raggio_cerchio_cicloide)),maxdelay,delay_cerchio5),mod_cicloide2b));
	cicloide_5_b3 = (Pan2.ar(DelayN.ar(SinOsc.ar(ffond*freq_cicloide*13, pi*(7/6),(afond*raggio_cerchio_cicloide)),maxdelay,delay_cerchio5),mod_cicloide3b));

	cicloide_6_b1 = (Pan2.ar(DelayN.ar(SinOsc.ar(ffond*freq_cicloide*13, pi/6,(afond*raggio_cerchio_cicloide)),maxdelay,delay_cerchio5),mod_cicloide4b));
	cicloide_6_b2 = (Pan2.ar(DelayN.ar(SinOsc.ar(ffond*freq_cicloide*13, pi*(5/6),(afond*raggio_cerchio_cicloide)),maxdelay,delay_cerchio5),mod_cicloide5b));
	cicloide_6_b3 = (Pan2.ar(DelayN.ar(SinOsc.ar(ffond*freq_cicloide*13, pi*(3/2),(afond*raggio_cerchio_cicloide)),maxdelay,delay_cerchio5),mod_cicloide6b));

	cicloidiB0 =  (cicloide_1_b1 + cicloide_1_b2 + cicloide_1_b3 + cicloide_2_b1 + cicloide_2_b2 + cicloide_2_b3 + cicloide_3_b1 + cicloide_3_b2 + cicloide_3_b3 + cicloide_4_b1 + cicloide_4_b2 + cicloide_4_b3 + cicloide_5_b1 + cicloide_5_b2 + cicloide_5_b3 + cicloide_6_b1 + cicloide_6_b2 + cicloide_6_b3)/18;

	   cicloidi_gruppo_B = cicloidiB0*cicloidiB;

    //sommatoria dei segnali

	signal =  (cerchi_fondamentali + cerchi_phase_modA + cerchi_phase_modB + cicloidi_gruppo_A + cicloidi_gruppo_B)/5;

	ReplaceOut.ar(outbus,FreeVerb2.ar((signal[0])*volume,(signal[1])*volume,mix,room,damp));
}).add;


x = Synth(\metatron);x.run(false);
)


s.freqscope
