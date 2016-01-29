# Description:
#   Attacks someone in the room
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot attack <target> - Attacks the target with a random weapon
#

module.exports = (robot) ->
  robot.on 'attack', (msg) ->
    attack( msg, msg.message.user )

  robot.respond /attack ([^\s]+)/i, (msg) ->
    victim = msg.match[1]
    victim = victim.substr( 1 ) if victim.charAt(0) is '@'

    users = robot.brain.usersForFuzzyName( victim )
    if users.length > 1
      msg.reply "I don't know who to attack with those piss poor directions"
      return

    victim = if users.length is 1 then users[0] else null

    if not victim
      msg.reply "You want me to attack someone who doesn't exist. You are strange."
      return

    attack( msg, victim )

  attack = (msg, victim) ->
    location = msg.random ["head", "head", "head", "body", "body", "body", "arms", "legs"]
    weapon = msg.random ["blade", "blade", "projectile", "projectile", "blunt", "blunt", "physical", "physical", "magic", "pokemon"]
    is_hit = msg.random ["#{weapon}", "#{weapon}", "#{weapon}", "#{weapon}", "#{weapon}", "#{weapon}", "#{weapon}", "#{weapon}", "#{weapon}", "miss"]

    victim_name = victim.name.charAt( 0 ).toUpperCase() + victim.name.slice( 1 )

    if location is "head"
      final_location = msg.random [
        "left eye",
        "right eye",
        "face",
        "head",
        "right ear",
        "left ear",
        "mouth",
        "temple",
        "scalp",
        "neck",
        "jugular",
        "esophagus",
        "throat"
      ]
    else if location is "body"
      final_location = msg.random [
        "chest",
        "armpit",
        "stomach",
        "spleen",
        "heart",
        "intestines",
        "back",
        "ass",
        "crotch",
        "spine",
        "shoulder",
        "nipple",
        "poops",
        "groin",
        "money maker",
        "gut",
      ]
    else if location is "arms"
      final_location = msg.random [
        "left elbow",
        "left forearm",
        "left hand",
        "left pinkie finger",
        "left thumb",
        "right elbow",
        "right forearm",
        "right hand",
        "right pinkie finger",
        "right thumb"
      ]
    else if location is "legs"
      final_location = msg.random [
        "left thigh",
        "left knee",
        "left kneecap",
        "left calf",
        "left ankle",
        "left foot",
        "right thigh",
        "right knee",
        "right kneecap",
        "right calf",
        "right ankle",
        "right foot"
      ]

    final_location = "*#{final_location}*"

    weapon_action = ''
    attack_motion = ''

    if weapon is "blade"
      weapon_action = msg.random [
        "pulls a wicked looking dagger from his boot",
        "unsheathes a razor-sharp katana",
        "hefts a massive claymore",
        "swings a nasty looking bastard sword",
        "flourishes a butterfly knife with uncanny speed",
        "pulls a switchblade from his sleeve",
        "unclips an unstable red lightsaber from his hip, thumbs it on with a snap-hiss",
        "grips his blue lightsaber, assumes a Vaapad stance",
        "pulls a sewing needle from his conveniently located pincushion",
        "flexes his fists, extending adamantium claws",
        "whirls an evil looking halberd above his head",
        "whips out a pointy-looking fencing foil",
        "breaks a bottle against the wall"
      ]

      attack_motion = msg.random [
        "lunges toward #{victim_name}",
        "flips over the head of #{victim_name}",
        "spins around #{victim_name}",
        "leaps toward #{victim_name}",
        "executes an expert 'Apple Blossoms in the Wind' toward #{victim_name}",
        "charges #{victim_name}",
        "springs toward #{victim_name}",
        "advances on #{victim_name}",
      ]

      attack_result = msg.random [
        "stabs 'em right in the #{final_location}",
        "slashes 'em right across the #{final_location} making you wince in pain",
        "impales their #{final_location}",
        "cuts their #{final_location} viciously",
        "hacks their #{final_location} repeatedly",
        "expertly pokes 'em right in the #{final_location}",
        "slices their #{final_location}"
      ]

      if is_hit is "miss"
        message = msg.random [
          "#{weapon_action}, #{attack_motion}, and misses like a complete and utter fool!",
          "#{weapon_action}, #{attack_motion}, and drops his weapon like a complete n00b!",
          "#{weapon_action}, #{attack_motion}, and trips over his own feet - tumbling to the ground in a heap!",
        ]
      else
        message = "#{weapon_action}, #{attack_motion}, and #{attack_result}!"
    else if weapon is "projectile"
      weapon_action = msg.random [
        "unholsters a DL-44 blaster pistol",
        "expertly aims an AK-47",
        "brandishes a vicious looking Kalashnikov",
        "nocks a bullet-point arrow into a camouflage compound bow",
        "nocks a self-fletched arrow into an oaken longbow",
        "loads a razor-tipped quarrel into his heavy crossbow",
        "places a hex-nut into his slingshot and pulls back",
        "looks down the sight of well-worn .22",
        "loads a rubber-band into his wooden rubber-band pistol",
        "cocks his Daisy pellet gun...10 times",
        "licks a suction cup dart and loads it into his Nerf gun",
        "lights a bottle rocket",
      ]

      attack_motion = msg.random [
        "takes aim at #{victim_name} and fires",
        "blindly fires at #{victim_name}",
        "dives sideways and fires at #{victim_name}",
        "laughs maniacally as he fires at #{victim_name}",
        "grins evilly as he opens fire at #{victim_name}",
      ]

      attack_result = msg.random [
        "hits 'em right in the #{final_location}",
        "pops 'em directly in the #{final_location}",
        "scores a direct hit on their #{final_location}",
      ]

      if is_hit is "miss"
        message = msg.random [
          "#{weapon_action}, #{attack_motion}, and misses like a complete and utter fool!",
          "#{weapon_action}, #{attack_motion}, and drops his weapon like a complete n00b!",
          "#{weapon_action}, #{attack_motion}, and trips over his own feet - tumbling to the ground in a heap!",
          "#{weapon_action}, #{attack_motion}, and accidentally shoots the wall!",
          "#{weapon_action}, #{attack_motion}, and misses his mark!",
        ]
      else
        message = "#{weapon_action}, #{attack_motion}, and #{attack_result}!"
    else if weapon is "blunt"
      weapon_action = msg.random [
        "brandishes a wicked looking warhammer",
        "hefts a vicious iron mace",
        "swings a brutally spiked oak club",
        "grips his well-worn Louisville Slugger",
        "breaks a leg off a chair",
        "angrily waves a tonfa",
        "picks up a nearby cast iron frying pan",
        "expertly spins his oaken quarterstaff",
        "clumsily wields a surfboard",
      ]

      attack_motion = msg.random [
        "lunges toward #{victim_name}",
        "flips over the head of #{victim_name}",
        "spins around #{victim_name}",
        "leaps toward #{victim_name}",
        "charges #{victim_name}",
        "springs toward #{victim_name}",
        "advances on #{victim_name}",
      ]

      attack_result = msg.random [
        "beats their #{final_location} to a fine red mist",
        "cracks bone as the hit connects with their #{final_location}",
        "bruises their #{final_location} with every swing of the weapon",
        "taps 'em lightly on the #{final_location}",
        "expertly knocks 'em right in the #{final_location}",
        "bashes 'em skillfully in the #{final_location}"
      ]

      if is_hit is "miss"
        message = msg.random [
          "#{weapon_action}, #{attack_motion}, and misses like a complete and utter fool!",
          "#{weapon_action}, #{attack_motion}, and drops his weapon like a complete n00b!",
          "#{weapon_action}, #{attack_motion}, and trips over his own feet - tumbling to the ground in a heap!",
        ]
      else
        message = "#{weapon_action}, #{attack_motion}, and #{attack_result}!"
    else if weapon is "physical"
      attack_motion = msg.random [
        "cartwheels toward #{victim_name}",
        "jumps and flips over #{victim_name}",
        "runs toward #{victim_name}",
        "charges toward #{victim_name}",
        "barrels recklessly toward #{victim_name}",
        "skips over to #{victim_name}",
        "brazingly taunts #{victim_name}",
      ]

      attack_result = msg.random [
        "roundhouse kicks 'em right in the #{final_location}",
        "hadoukens 'em right in the #{final_location}",
        "knife hands their #{final_location}",
        "hammer fists 'em right in the #{final_location}",
        "performs a flying knee right to the #{final_location}",
        "brutally headbutts 'em right in the #{final_location}",
        "squats low, then jumps up with a wicked kick to the #{final_location}",
        "bicycle kicks 'em right in the #{final_location}",
        "bites 'em right on the #{final_location}",
        "repeatedly scratches at their #{final_location}",
        "pinches 'em right in the #{final_location}",
        "cruelly flicks 'em right on the #{final_location}",
      ]

      if is_hit is "miss"
        message = msg.random [
          "#{attack_motion}, and misses like a complete and utter fool!",
          "#{attack_motion}, and hits nothing but air as his attack goes wide!",
          "#{attack_motion}, and trips over his own feet - tumbling to the ground in a heap!",
        ]
      else
        message = "#{attack_motion} and #{attack_result}!"
    else if weapon is "magic"
      attack_motion = msg.random [
        "mutters an incantation under his breath",
        "traces an arcane symbol in the air",
        "touches an arcane looking tattoo on his harm, pointing to #{victim_name}",
        "grips a glowing amulet as he thrusts his hand toward #{victim_name}",
        "screams a string of gibberish at #{victim_name}",
      ]

      attack_result = msg.random [
        "hurls a *fireball* right at #{victim_name}, burning 'em to a crisp",
        "*polymorphs* #{victim_name} into a miniature pony",
        "materializes a *magic missle* that curves through the air right to #{victim_name}",
        "forks *lightning* from his fingertips right at #{victim_name}",
        "causes a *cloud of noxious gas* to appear from nowhere to settle right over #{victim_name}",
        "slams a *wall of air* right into #{victim_name}, knocking 'em off their feet",
        "fires a beam of *pure energy* right into the #{final_location} of the poor unsuspecting #{victim_name}",
      ]

      message = "#{attack_motion} and #{attack_result}!"
    else if weapon is "pokemon"
      attack_motion = msg.random [
        "pulls a pokeball from his satchel and throws it toward #{victim_name}",
        "hurls a pokeball right toward #{victim_name}",
        "expertly tosses a pokeball toward #{victim_name}",
        "rolls a pokeball toward #{victim_name}",
      ]

      attack_result = msg.random [
        "*Pidgeotto*! Wing attack!",
        "*Pikachu*! Lightning attack!",
        "*Squirtle*! Water Gun attack!",
        "*Charizard*! Ember attack!",
        "*Clefairy*! Metrenome...NOW!",
        "*Meowth*! Fury Swipes...NOW!",
        "*Geodude*! Rock Throw attack!",
        "*Zubat*! Wing Cutter attack!",
        "*Rattata*! Bite attack!",
        "*Sandshrew*! Sandstorm attack...NOW!",
        "*Bulbasaur*! Poison Powder attack!",
        "*Butterfree*! Stun Spore...NOW!",
        "*Magikarp*! Shit...uh...Flail, I guess?",
        "*Psyduck*! Aqua Tail attack...NOW!",
      ]

      message = "#{attack_motion} and shouts: 'I choose you, #{attack_result}!'"

    msg.emote "_#{message}_"
