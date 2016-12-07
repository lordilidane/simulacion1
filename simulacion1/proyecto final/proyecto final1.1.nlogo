 turtles-own [energia
              resistencia
              confortable

              ]
 globals[temperatura
         amonio
         controlTemperaturaColorAnterior
         ph
          ]
to setup
    clear-all

    ;;setup-patches
    setup-turtles
    do-plots

    set temperatura 30
    set amonio 0
    set ph 7
    ask turtles [set confortable 1
      ]
 end
to temp [x]

  if( (random 4) = 2)[
  ifelse (random 10) < x
      [set temperatura(temperatura + 1)]
      [set temperatura(temperatura - 1)]
  ]
end

to-report calcularProbabilidad [valor medio desviacion] ;;esta fuincion me ayuda a calcular la probabilidad de mi funcion de aleatoriedad
                                         ;;valor es el valor actual de mi variable es este el que voy a comparar con mi media
      let estado abs ( valor - medio )   ;;tambien me ha ayudado de una desviación para establecer un rango de mi variable aleata
      let rangos (desviacion / 10)
      let prioridad ((estado / rangos) / 5)
      let numprioridad  (5 + prioridad)

       ifelse ( random 10 < numprioridad)
          [report 1]
          [report 0]
end

to temperaturaAxion [ x valor media] ;;este metodo aplica la axion sobre la temperatura donde x es el valor de prbabilidad binario que me indica si debo o nó aumentar o disminuir la temperatura
  ifelse( media - valor > 0)   ;; en esta decicion calculamos si es necesario aumentar o disminuir la temperatuta dependiendo si la temperatura está por debajo o por encima de la media
  [                                  ;; los parametros de valor y media me ayudan a saber si la temperatura debe elevarse o disminuirse
 if( (random 4) = 2)[                ;; es decir obtengo el singno negativo o positivo de la operacion media - valor para
  ifelse x = 1                       ;; saber si disminuir o aumentar la temperatura
      [set temperatura(temperatura + 1)]
      [set temperatura(temperatura - 1)]
  ]
  ]
  [
     if( (random 4) = 2)[
  ifelse x = 1
      [set temperatura(temperatura - 1)]
      [set temperatura(temperatura + 1)]
       ]

    ]

end

to amonioCalcular [x]
  let variacion 0.05

  if( (random 4) = 2)[
  ifelse x = 1
      [
       if(amonio >= variacion)
        [
          ifelse((amonio - variacion) <= 1.7 and (amonio - variacion) >= 1.3) ;; el valor 1.5 tiene 3 veces las probabilidades que los demás, es por esto que hemos decidido reducirle sus probabilidades en un tercio
          [
           if((random 3) = 0)
             [set amonio(amonio - variacion)]
          ]
          [set amonio(amonio - variacion)]
          ]
        ]
      [ifelse((amonio + variacion) <= 1.7 and (amonio + variacion) >= 1.3) ;; el valor 1.5 tiene 3 veces las probabilidades que los demás, es por esto que hemos decidido reducirle sus probabilidades en un tercio
          [
           if((random 3) = 0)
             [set amonio(amonio + variacion)]
          ]
          [set amonio(amonio + variacion)]]
       ]
  set amonio precision amonio 3

   afectacionTemperaturaAmonio;;terminar este método

end

to phCalcular [ x valor media] ;;este metodo aplica la axion sobre la temperatura donde x es el valor de prbabilidad binario que me indica si debo o nó aumentar o disminuir la temperatura
  ifelse( media - valor > 0)   ;; en esta decicion calculamos si es necesario aumentar o disminuir la temperatuta dependiendo si la temperatura está por debajo o por encima de la media
  [                                  ;; los parametros de valor y media me ayudan a saber si la temperatura debe elevarse o disminuirse
 if( (random 4) = 2)[                ;; es decir obtengo el singno negativo o positivo de la operacion media - valor para
  ifelse x = 1                       ;; saber si disminuir o aumentar la temperatura
      [set ph(ph + 1)]
      [set ph(ph - 1)]
  ]
  ]
  [
     if( (random 4) = 2)[
  ifelse x = 1
      [set ph(ph - 1)]
      [set ph(ph + 1)]
       ]

    ]

end

to afectacionTemperaturaAmonio


end

to calcularResistencia [enConfot valorAComparar mediaDeValor desviacion desviacionValorCritico] ;;en confort 1 o 0 %de desviacion deslizabledeValor
;;let incidenciaTemperatucaAlAmonio 0.01
let resistenciaEnConfot (%recuperacion / 10000)
  ifelse (enConfot = 1)
  [
      ask turtles [
        if(confortable != 0)[
        if(resistencia + resistenciaEnConfot <= 1 )
          [
             ;;let asignarResistencia (desviacionTemperaturaCritica - D27)/desviacionTemperaturaCritica
             set resistencia resistencia + resistenciaEnConfot
              ]
        set confortable 1
        ]
        ;;if (%deDesviacion >= 2)[ ;; en esta parte del código la temperatura afectará positivamente al amonio
        ;;set %deDesviacion ( %deDesviacion - incidenciaTemperatucaAlAmonio )
        ;;set %deDesviacion precision %deDesviacion 2
        ;;]

    ]
 ]
  [
   ask turtles [


      set confortable 0
      ;;if (%deDesviacion <= 6)[;; en esta parte del código la temperatura afectará negativamente al amonio
      ;;   set %deDesviacion (%deDesviacion + incidenciaTemperatucaAlAmonio )
      ;;   set %deDesviacion precision %deDesviacion 2
      ;;]
            let desviacionDelConfort abs (abs( mediaDeValor - valorAComparar ) - desviacion)
            let estadoCritico (1 - (desviacionValorCritico - desviacionDelConfort) / desviacionValorCritico ) / 100
            set estadoCritico (estadoCritico * %perdida / 10)

          if(resistencia - estadoCritico >= estadoCritico)
          [
            set resistencia resistencia - estadoCritico

            ]
      ]
   ask turtles [
        set resistencia precision resistencia 3
        if(resistencia < 0.0)
        [set resistencia 0]

     ]

 ]
end

to calcularConfortTemperatura [desviacionTemperaturaCritica media desviacion]

;;let resistenciaEnConfot random 0.04

;;let resistenciaEnConfot random 50 / 1000
;;let incidenciaTemperatucaAlAmonio 0.01
;;let resistenciaEnConfot (%recuperacion / 10000)
 ifelse(temperatura <= 32 and temperatura >= 28)[
     calcularResistencia 1 temperatura media desviacion desviacionTemperaturaCritica
     if(automatico-desviacion-amonio?)[
     if (%desviacion-amonio >= 2)[ ;; en esta parte del código la temperatura afectará positivamente al amonio
        set %desviacion-amonio (%desviacion-amonio - inciden-tem-amonio )
        set %desviacion-amonio precision %desviacion-amonio 2
       ]
     ]
 ]
 [

     calcularResistencia 0 temperatura media desviacion desviacionTemperaturaCritica
     ;;set %desviacion-amonio (%desviacion-amonio - inciden-tem-amonio )                                         ;;arreglar esta variable
     if(automatico-desviacion-amonio?)[
     if (%desviacion-amonio <= 6)[;; en esta parte del código la temperatura afectará negativamente al amonio
         set %desviacion-amonio (%desviacion-amonio + inciden-tem-amonio )
         set %desviacion-amonio precision %desviacion-amonio 2
      ]
     ]
 ]
end

to calcularEnergia
  ask turtles[
    ;;let ganancia random (ganancia-energia * (1 - resistencia ))
    let ganancia  (ganancia-energia * (1 - resistencia ))
    if(ganancia <= 0.009)
    [set ganancia 0.01]
    ;;print ganancia-energia * (1 - resistencia )
   ifelse(confortable = 1)
   [

    ;;if(energia <= (energia + ganancia)) [

    if(energia <= (100 - ganancia)) [
      set energia energia + ganancia]

    ]
   [
     set energia energia - ganancia

     ]

     set energia precision energia 2
   ]

end

to calcularConfortAmonio [desviacionAmonioturaCritica media desviacion]

   ifelse ( amonio <= 0.5)
      [
       ;;if(confortable != 0)
         ;;[
           ;;[enConfot %deDesviacion valorAComparar mediaDeValor desviacion desviacionValorCritico]

           calcularResistencia 1 amonio media desviacion desviacionAmonioturaCritica
           ;;]
       ]
        [
          calcularResistencia 0 amonio media desviacion desviacionAmonioturaCritica
          ]

end

  to calcularConfortph
  ask turtles [
   ifelse ( ph >= 4 and ph <= 11)
      [
       if(confortable != 0)
         [set confortable 1]

       ]
        [set confortable 0]
  ]
end


 to go
    ;;if ticks >= 500 [ stop ]
    move-turtles
    let mediatemperatura 30
    let desviacionTemperatura %desviacion-temperatura

    let mediAamonio  0
    let desviacionAmonio %desviacion-amonio

    let mediaph  7
    let desviacionph  5

    ask turtles[set color red + ( int (energia / 10 )) * 10]
    ;eat-grass
    ;reproduce

    ifelse(temperatura-automatica?)
       [temperaturaAxion (calcularProbabilidad temperatura mediatemperatura desviacionTemperatura) temperatura mediatemperatura]
       [set temperatura temperatura-manual]
    ifelse(amonio-automatico?)
      [amonioCalcular (calcularProbabilidad amonio mediAamonio desviacionAmonio)]
      [set amonio amonio-manual]
    ifelse(ph-automatico?)
      [phCalcular;; (calcularProbabilidad ph mediaph desviacionph) mediaph
         (calcularProbabilidad ph mediaph desviacionph) ph mediaph]
      [set ph ph-manual]
    ;;iterarTemperatura
    let desviacionTemperaturaCritica 4
    calcularConfortTemperatura desviacionTemperaturaCritica mediatemperatura desviacionTemperatura
    ;;calcularEnergia
    let desviacionAmonioturaCritica 1
    calcularConfortAmonio desviacionAmonioturaCritica mediAamonio desviacionAmonio

    calcularConfortph
    calcularEnergia

    calcularEnergia
    colorearTemperatura
    check-death
   ;;regrow-grass
    ;;tick
    do-plots
    ask turtles [
      set confortable 1
    ]
 end

to setup-turtles
    create-turtles numero
    ask turtles [ setxy random-xcor random-ycor
                  set shape "fish"
                  set energia random 100
                  set resistencia (random 100 / 100)
                  set color red + ( int (energia / 10 )) * 10
                  set size 5


    ]



      ;;ask turtle (show[who] with[])

    ;;ask turtles [
    ;;         while [who < numero][
    ;;              set resistencia random-normal 100 30
    ;;           ]
    ;;           ]
 end
 to setup-patches
    ask patches [ set pcolor green ]
 end




;;  to reproduce ;; reproducirse
;;    ask turtles [
;;       if energy > 50 [
;;            ;;set energy energy - 50
;;            set energy energy - birth-energy
;;             hatch 1 [ set energy birth-energy ]
;;          ]
;;       ]
;; end

 to check-death ;; verificar muerte
      ask turtles [
          if energia <= 0 [ die ]

       ]
 end

 to regrow-grass ;; rebrotar pasto
    ask patches [
       if random 100 < 3 [ set pcolor green ]
       ]
 end
  to eat-grass
    ask turtles [
 if pcolor = green [
 set pcolor black
       ;; set energy (energy + energy-from-grass)
    ]
       ifelse show-energy?
       [ set label energia ]
       [ set label "" ]
    ]
 end

 to move-turtles
    ask turtles [

     ; while [any? other turtles-here][
           right random 45
           left random 45
           fd 1
     ;;      ]

    ;;ifelse temperatura >=  28
    ;;  [set energy (energy - 1)]
    ;;  [set energy (energy + 1)]

    ifelse show-energy?
       [ set label energia ]
       [ set label "" ]
    ;;set energy energy - 1 ]
    ]
 end

 to do-plots
   set-current-plot "Totals"
   set-current-plot-pen "peces"
   plot count turtles
   ;;set-current-plot-pen "grass"
   ;;plot count patches with [pcolor = green]



   set-current-plot "amonio"
   set-current-plot-pen "amonio"
    ifelse ( amonio <= 0.5)
      [
       set-plot-pen-color green
       ]
      [set-plot-pen-color red]
    plot amonio


  set-current-plot "ph"
   set-current-plot-pen "ph"
   ifelse ( ph >= 4 and ph <= 11)
      [
       set-plot-pen-color green
       ]
      [set-plot-pen-color red]
   plot ph


   set-current-plot "nivel-de-crecimiento"
   set-current-plot-pen "nivel-de-crecimiento"
   ;;ask turtles [
      ;; plot resistencia
      ;;plot energia
   ;;]

  ask turtles[
       if( who = 0)
       [;;print energia
        plot energia]
    ]
 end

to iterarTemperatura
  let temper 5
    if(temperatura >= 30)
          [set temper 5]
        if(temperatura >= 32)
          [set temper 4]
         if(temperatura >= 34)
          [set temper 3]
        if(temperatura >= 36)
          [set temper 2]


      if(temperatura <= 24)
          [set temper 5]
      if(temperatura <= 25)
          [set temper 6]
      if(temperatura <= 23)
          [set temper 7]
      if(temperatura <= 22)
          [set temper 8]

   temp temper
end
to plotTemperatura [colorActual]
   set-current-plot "temperatura"
   set-current-plot-pen "temperatura"
   set-plot-pen-color colorActual
   plot temperatura
end
to colorearTemperatura

  let colorActual [pcolor] of patch 0 0
  if(temperatura >= 40)
  [ set colorActual (red - 2 )]
   if(temperatura >= 35 and temperatura <= 39)
     [set colorActual red - 1 ]
     ;;  ask patches [ set pcolor red]]
    if(temperatura = 34)
     [set colorActual (red)]
    if(temperatura = 33)
     [set colorActual (red + 2)]
   if(temperatura = 32)
     [set colorActual (red + 3)]

   if(temperatura > 28 and temperatura < 32)
     [set colorActual green + 1 ]

   ;;if(temperatura = )
   ;;  [ask patches [ set pcolor green ]]

   if(temperatura = 27)
      [set colorActual (blue + 3) ]
   if(temperatura = 26)
      [set colorActual (blue + 2) ]
   if(temperatura = 25)
      [set colorActual (blue) ]
   if(temperatura <= 24)
      [set colorActual (blue - 1 )]

    plotTemperatura colorActual

 ifelse(colorear-temperatura?)[
   if(colorActual != controlTemperaturaColorAnterior)
      [ask patches [set pcolor colorActual]]
   set controlTemperaturaColorAnterior [pcolor] of patch 0 0
 ]
 [
   set colorActual [pcolor] of patch 0 0
   if(colorActual != controlTemperaturaColorAnterior or colorActual != blue)
      [ask patches [set pcolor blue]]

   set controlTemperaturaColorAnterior [pcolor] of patch 0 0
      ]
end
@#$#@#$#@
GRAPHICS-WINDOW
297
16
736
476
16
16
13.0
1
10
1
1
1
0
1
1
1
-16
16
-16
16
0
0
1
ticks
30.0

BUTTON
3
10
66
43
NIL
setup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
71
13
134
46
NIL
go
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SWITCH
143
14
277
47
show-energy?
show-energy?
0
1
-1000

MONITOR
145
160
228
205
NIL
count turtles
17
1
11

PLOT
29
199
229
349
Totals
time
totals
0.0
10.0
0.0
10.0
true
true
"" ""
PENS
"peces" 1.0 0 -7500403 true "" ""

SLIDER
15
56
107
89
numero
numero
0
100
13
1
1
NIL
HORIZONTAL

MONITOR
1198
10
1280
55
NIL
temperatura
17
1
11

PLOT
782
11
982
161
Temperatura
Tiempo
Tepmeratura
0.0
10.0
20.0
40.0
true
false
"" ""
PENS
"temperatura" 1.0 0 -5298144 true "" ""

PLOT
786
176
986
326
amonio
NIL
NIL
0.0
10.0
0.0
2.0
true
false
"" ""
PENS
"amonio" 1.0 0 -1184463 true "" "plot amonio"

SWITCH
992
17
1182
50
temperatura-automatica?
temperatura-automatica?
1
1
-1000

SWITCH
1002
190
1168
223
amonio-automatico?
amonio-automatico?
1
1
-1000

SLIDER
991
58
1176
91
temperatura-manual
temperatura-manual
-10
80
30
1
1
NIL
HORIZONTAL

SLIDER
1001
228
1173
261
amonio-manual
amonio-manual
0
5
0.1
0.1
1
NIL
HORIZONTAL

SWITCH
992
101
1177
134
colorear-temperatura?
colorear-temperatura?
1
1
-1000

MONITOR
1205
185
1262
230
amonio
amonio
4
1
11

SLIDER
1192
60
1284
93
%desviacion-temperatura
%desviacion-temperatura
0.1
10
2.4
0.1
1
NIL
HORIZONTAL

SLIDER
1197
233
1289
266
%desviacion-amonio
%desviacion-amonio
0.1
10
2
0.1
1
NIL
HORIZONTAL

PLOT
19
366
219
516
nivel-de-crecimiento
NIL
NIL
0.0
10.0
0.0
1.0
true
false
"" ""
PENS
"nivel-de-crecimiento" 1.0 0 -13210332 true "" ""

SLIDER
16
119
127
152
%recuperacion
%recuperacion
0
100
38
1
1
NIL
HORIZONTAL

SLIDER
134
118
226
151
%perdida
%perdida
0
100
21
1
1
NIL
HORIZONTAL

SLIDER
115
57
230
90
ganancia-energia
ganancia-energia
0
10
2
0.1
1
NIL
HORIZONTAL

PLOT
789
340
989
490
ph
NIL
NIL
0.0
10.0
0.0
14.0
true
false
"" ""
PENS
"ph" 1.0 0 -13210332 true "" ""

SLIDER
1000
382
1172
415
ph-manual
ph-manual
0
14
8
1
1
NIL
HORIZONTAL

SLIDER
1187
105
1296
138
inciden-tem-amonio
inciden-tem-amonio
0
0.1
0.069
0.001
1
NIL
HORIZONTAL

SWITCH
1198
273
1288
306
automatico-desviacion-amonio?
automatico-desviacion-amonio?
1
1
-1000

SWITCH
1004
345
1172
378
ph-automatico?
ph-automatico?
1
1
-1000

@#$#@#$#@
## WHAT IS IT?

(a general understanding of what the model is trying to show or explain)

## HOW IT WORKS

(what rules the agents use to create the overall behavior of the model)

## HOW TO USE IT

(how to use the model, including a description of each of the items in the Interface tab)

## THINGS TO NOTICE

(suggested things for the user to notice while running the model)

## THINGS TO TRY

(suggested things for the user to try to do (move sliders, switches, etc.) with the model)

## EXTENDING THE MODEL

(suggested things to add or change in the Code tab to make the model more complicated, detailed, accurate, etc.)

## NETLOGO FEATURES

(interesting or unusual features of NetLogo that the model uses, particularly in the Code tab; or where workarounds were needed for missing features)

## RELATED MODELS

(models in the NetLogo Models Library and elsewhere which are of related interest)

## CREDITS AND REFERENCES

(a reference to the model's URL on the web if it has one, as well as any other necessary credits, citations, and links)
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

fish 2
false
0
Polygon -1 true false 56 133 34 127 12 105 21 126 23 146 16 163 10 194 32 177 55 173
Polygon -7500403 true true 156 229 118 242 67 248 37 248 51 222 49 168
Polygon -7500403 true true 30 60 45 75 60 105 50 136 150 53 89 56
Polygon -7500403 true true 50 132 146 52 241 72 268 119 291 147 271 156 291 164 264 208 211 239 148 231 48 177
Circle -1 true false 237 116 30
Circle -16777216 true false 241 127 12
Polygon -1 true false 159 228 160 294 182 281 206 236
Polygon -7500403 true true 102 189 109 203
Polygon -1 true false 215 182 181 192 171 177 169 164 152 142 154 123 170 119 223 163
Line -16777216 false 240 77 162 71
Line -16777216 false 164 71 98 78
Line -16777216 false 96 79 62 105
Line -16777216 false 50 179 88 217
Line -16777216 false 88 217 149 230

fish 3
true
0
Polygon -7500403 true true 137 105 124 83 103 76 77 75 53 104 47 136
Polygon -7500403 true true 226 194 223 229 207 243 178 237 169 203 167 175
Polygon -7500403 true true 137 195 124 217 103 224 77 225 53 196 47 164
Polygon -7500403 true true 40 123 32 109 16 108 0 130 0 151 7 182 23 190 40 179 47 145
Polygon -7500403 true true 45 120 90 105 195 90 275 120 294 152 285 165 293 171 270 195 210 210 150 210 45 180
Circle -1184463 true false 244 128 26
Circle -16777216 true false 248 135 14
Line -16777216 false 48 121 133 96
Line -16777216 false 48 179 133 204
Polygon -7500403 true true 241 106 241 77 217 71 190 75 167 99 182 125
Line -16777216 false 226 102 158 95
Line -16777216 false 171 208 225 205
Polygon -1 true false 252 111 232 103 213 132 210 165 223 193 229 204 247 201 237 170 236 137
Polygon -1 true false 135 98 140 137 135 204 154 210 167 209 170 176 160 156 163 126 171 117 156 96
Polygon -16777216 true false 192 117 171 118 162 126 158 148 160 165 168 175 188 183 211 186 217 185 206 181 172 171 164 156 166 133 174 121
Polygon -1 true false 40 121 46 147 42 163 37 179 56 178 65 159 67 128 59 116

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270

@#$#@#$#@
NetLogo 5.2.1
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180

@#$#@#$#@
0
@#$#@#$#@
