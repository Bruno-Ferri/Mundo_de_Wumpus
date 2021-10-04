require 'ruby2d'
set title: 'Mundo de Wumpus'
set width: 420
$pontos = 0
$casa12= Square.new(
 x: 0, y: 0, z: 0,
 size: 100,
 color: 'green'
)
$casa13= Square.new(
 x: 105, y: 0, z: 0,
 size: 100,
 color: 'green'
)
$casa14= Square.new(
 x: 210, y: 0, z: 0,
 size: 100,
 color: 'green'
)
$casa15= Square.new(
 x: 315, y: 0, z: 0,
 size: 100,
 color: 'green'
)
$casa8= Square.new(
 x: 0, y: 105, z: 0,
 size: 100,
 color: 'green'
)
$casa9= Square.new(
 x: 105, y: 105, z: 0,
 size: 100,
 color: 'green'
)
$casa10= Square.new(
 x: 210, y: 105, z: 0,
 size: 100,
 color: 'green'
)
$casa11= Square.new(
 x: 315, y: 105, z: 0,
 size: 100,
 color: 'green'
)
$casa4= Square.new(
 x: 0, y: 210, z: 0,
 size: 100,
 color: 'green'
)
$casa5= Square.new(
 x: 105, y: 210, z: 0,
 size: 100,
 color: 'green'
)
$casa6= Square.new(
 x: 210, y: 210, z: 0,
 size: 100,
 color: 'green'
)
$casa7= Square.new(
 x: 315, y: 210, z: 0,
 size: 100,
 color: 'green'
)
$casa0= Square.new(
 x: 0, y: 315, z: 0,
 size: 100,
 color: 'green'
)
$casa1= Square.new(
 x: 105, y: 315, z: 0,
 size: 100,
 color: 'green'
)
$casa2= Square.new(
 x: 210, y: 315, z: 0,
 size: 100,
 color: 'green'
)
$casa3= Square.new(
 x: 315, y: 315, z: 0,
 size: 100,
 color: 'green'
)

$pontos_txt = Text.new(
    "Pontos: #{$pontos}",
    x: 0, y: 420, z: 5,
    size: 15,
    color: "white"
)
$posicoes_casas_x = [0,105,210,315,0,105,210,315,0,105,210,315,0,105,210,315]
$posicoes_casas_y = [315,315,315,315,210,210,210,210,105,105,105,105,0,0,0,0]

$atirou = false
$pegou_ouro = false
def gera_poco
 $poco1=rand(15)+1
 $poco2=rand(15)+1
 $poco3=rand(15)+1
end
def gera_wumpus
 $wumpus_pos=rand(15)+1
end
def define_casas
  for i in 0 .. 15
    if($casas[i].include? "poco") then
      $casas[i+4] += "brisa"
      $casas[i-4] += "brisa"
      if(i%4 == 0 || (i-1)%4==0 || (i-2)%4==0) then
        $casas[i+1] += "brisa"
      end
      if((i+1)%4==0 || (i+2)%4==0 || (i+3)%4==0) then
        $casas[i-1] += "brisa"
      end
    end
    if($casas[i].include? "wumpus") then
      $casas[i+4] += "fedor"
      $casas[i-4] += "fedor"
      if(i%4 == 0 || (i-1)%4==0 || (i-2)%4==0) then
        $casas[i+1] += "fedor"
      end
      if((i+1)%4==0 || (i+2)%4==0 || (i+3)%4==0) then
        $casas[i-1] += "fedor"
      end
    end
  end
end
def gera_ouro
  $ouro=rand(16)
  while($ouro==$poco1 || $ouro==$poco2 || $ouro == $poco3)
    $ouro=rand(16)
  end
end
def game_over
  game_over_txt = Text.new(
    "GAME OVER",
    x: 100, y: 100, z: 10,
    size: 50,
    color: 'yellow'
  )
  $img_guerreiro.remove
  $pontos-=1000
end 
def vitoria
    vitoria_txt = Text.new(
    "VITÓRIA!!!",
    x: 100, y: 100, z: 10,
    size: 50,
    color: 'yellow'
  )
   $img_guerreiro.remove
end
def pega_ouro
   $pegou_ouro = true
   $ouro_img.remove
   $pontos+= 100
end
def mata_wumpus
   $wumpus_pos=18
   grito = Sound.new('./som/grito.mp3')
   grito.play
end
def verifica_tiro
   case $guerreiro_direcao
      when 0
      if(($wumpus_pos - $casa_guerreiro) > 0 && ($wumpus_pos - $casa_guerreiro) < 4) then
         mata_wumpus
      end
      when 1
      if(($wumpus_pos - $casa_guerreiro)%4 == 0 && ($wumpus_pos - $casa_guerreiro) > 0) then
         mata_wumpus
      end
      when 2
      if(($wumpus_pos - $casa_guerreiro) < 0 && ($wumpus_pos - $casa_guerreiro) > -4) then
         mata_wumpus
      end
      when 3
      if(($wumpus_pos - $casa_guerreiro)%4 == 0 && ($wumpus_pos - $casa_guerreiro) < 0) then
         mata_wumpus
      end
   end
end
def mapa
  for i in 0 .. 15
    if (($casas[i].include? "poco") && $casa_guerreiro == i) then
       poco_img = Image.new(
       './img/poco.png',
       x:$posicoes_casas_x[i] , y: $posicoes_casas_y[i], z: 5
       )
    end
    if (($casas[i].include? "brisa") && $casa_guerreiro == i) then
       poco_img = Image.new(
       './img/brisa.png',
       x:$posicoes_casas_x[i] , y: $posicoes_casas_y[i], z: 5
       )
    end
    if (($casas[i].include? "fedor") && $casa_guerreiro == i) then
       fedor_img = Image.new(
       './img/fedor.png',
       x:$posicoes_casas_x[i] , y: $posicoes_casas_y[i], z: 5
       )
    end
    if (($casas[i].include? "wumpus") && $casa_guerreiro == i) then
       $wumpus_img = Image.new(
       './img/wumpus.png',
       x:$posicoes_casas_x[i] , y: $posicoes_casas_y[i], z: 5
       )
    end
    if (($casas[i].include? "ouro") && $casa_guerreiro == i && $pegou_ouro == false) then
       $ouro_img = Image.new(
       './img/ouro.png',
       x:$posicoes_casas_x[i] , y: $posicoes_casas_y[i], z: 5
       )
    end
  end
end
gera_poco
gera_wumpus
gera_ouro
$casas = Array.new(19)
for i in 0 .. 19
  $casas[i] = "0"
end
$casas[$poco1] += "poco"
$casas[$poco2] += "poco"
$casas[$poco3] += "poco"
$casas[$wumpus_pos] += "wumpus"
$casas[$ouro] += "ouro"
define_casas

$guerreiro_posicao_x=0
$guerreiro_posicao_y=315
#direcao: 0:direita,1:cima,2:esquerda,3:baixo
$guerreiro_direcao=0
$casa_guerreiro=0
$img_guerreiro=Image.new(
     './img/guerreiro.png', 
     x: $guerreiro_posicao_x, y: $guerreiro_posicao_y, z: 5, 
     rotate: 90
    )
on :key_up do |event|
  if (event.key=='left ctrl' && $guerreiro_direcao>=0 && $guerreiro_direcao<=3) then
     $guerreiro_direcao+=1
     $img_guerreiro.rotate-= 90
     if ($guerreiro_direcao==4) then
        $guerreiro_direcao=0
     end
     $pontos-=1
  end
    if (event.key=='right ctrl' && $guerreiro_direcao>=0 && $guerreiro_direcao<=3) then
     $guerreiro_direcao-=1
     $img_guerreiro.rotate+= 90
     if ($guerreiro_direcao==-1) then
        $guerreiro_direcao=3
     end
     $pontos-=1
  end
  if (event.key=='up' && $guerreiro_direcao==1 && ($casa_guerreiro+3)<15) then
    $guerreiro_posicao_y-=105
    $casa_guerreiro+=4
    $img_guerreiro.x = $guerreiro_posicao_x
    $img_guerreiro.y = $guerreiro_posicao_y
    mapa
    $pontos-=1
  end
  if (event.key=='right' && $guerreiro_direcao==0 && ($casa_guerreiro+1)%4!=0) then
    $guerreiro_posicao_x+=105
    $casa_guerreiro+=1
    $img_guerreiro.x = $guerreiro_posicao_x
    $img_guerreiro.y = $guerreiro_posicao_y
    mapa
    $pontos-=1
  end
  if (event.key=='left' && $guerreiro_direcao==2 && $casa_guerreiro%4!=0) then
    $guerreiro_posicao_x-=105
    $casa_guerreiro-=1
    $img_guerreiro.x = $guerreiro_posicao_x
    $img_guerreiro.y = $guerreiro_posicao_y
    mapa
    $pontos-=1
  end
  if (event.key=='down' && $guerreiro_direcao==3 && ($casa_guerreiro-3)>0) then
    $guerreiro_posicao_y+=105
    $casa_guerreiro-=4
    $img_guerreiro.x = $guerreiro_posicao_x
    $img_guerreiro.y = $guerreiro_posicao_y
    mapa
    $pontos-=1
  end
  if ($casa_guerreiro==$poco1 || $casa_guerreiro==$poco2 || $casa_guerreiro==$poco3 || $casa_guerreiro==$wumpus_pos) then
     game_over
  end
  if (event.key=='a' && $casa_guerreiro==$ouro && $pegou_ouro==false) then
     pega_ouro
     $pontos-=1
  end
  if (event.key=='q' && $atirou==false) then
     $atirou=true
     verifica_tiro
     $pontos-=1
  end
  if (event.key=='s' && $pegou_ouro==true && $casa_guerreiro==0) then
     vitoria
  end
  $pontos_txt.text = "Pontos: #{$pontos}"
end
mapa

show
