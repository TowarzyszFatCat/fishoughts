extends Node2D

@onready var harpoon = $harpoon
@onready var press_any = $cl/press_any_key
@onready var talk = $cl/talk_mc

var t_name
var t_dialog


func _ready():
	$cl/mc.visible = false
	$audio.playing = true
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
	t_name = $cl/talk_mc/talk/mc/VBoxContainer/name
	t_dialog = $cl/talk_mc/talk/mc/VBoxContainer/dialog
	
	harpoon.process_mode = Node.PROCESS_MODE_DISABLED
	harpoon.visible = false
	press_any.visible = true
	talk.visible = false

func _process(delta):
	$cl/mc/counter.text = str(caught_fishes)
	
	if Input.is_anything_pressed() && press_any.visible:
		press_any.visible = false
		$eye_anim/AnimationPlayer.play("open")
		
		glov.spawn_speed = 0.1
		await get_tree().create_timer(5).timeout
		
		await talk_func("Stranger", "Welcome, traveler, to the realm of the drifting thoughts. You've stumbled upon this place for a reason...", 0)
		await talk_func("Stranger", "In this vast void, everything is in constant motion... Seemingly pointless. But don't be afraid, because I'm here to guide you.", 0)
		glov.points = false
		
		glov.spawn_speed = 0.3
		await  talk_func("Stranger", "I've transformed these drifting thoughts into fishes to aid your understanding. Each fish carries thoughts, memories, and dilemmas.", 0)
		glov.spawn_speed = 1.5
		
		await  talk_func("Stranger", "As you harpoon into the abyss, remember that each fish represents a fragment of existence waiting to be grasped and understood. The Void Harpoon hits the first target in its path.", 0)
		await  talk_func("Stranger", "You see, I forgot to introduce myself. I am the ruler of this void... I'm Void Master.", 0)
		
		harpoon.visible = true
		harpoon.process_mode = Node.PROCESS_MODE_INHERIT
		

func talk_func(f_name, f_dialog, type):
	harpoon.visible = false
	harpoon.process_mode = Node.PROCESS_MODE_DISABLED
	
	if type == 0 or 1:
		t_name.set("theme_override_colors/font_color", Color(0.929, 0, 0.667))
	if type == 2:
		t_name.set("theme_override_colors/font_color", fish_color)
	if type == 10:
		t_name.set("theme_override_colors/font_color", Color(0.298, 1, 0))
	if type == 20:
		t_name.set("theme_override_colors/font_color", Color(0, 0.855, 1))
	if type == 30:
		t_name.set("theme_override_colors/font_color", Color(0.907, 0.637, 1))
	if type == 50:
		t_name.set("theme_override_colors/font_color", Color(0.298, 1, 0))
	
	talk.visible = true
	t_name.text = f_name
	t_dialog.text = ''
	
	var dial_len = len(f_dialog)
	
	for i in dial_len:
		if f_dialog[i] == " ":
			t_dialog.text += f_dialog[i]
		elif f_dialog[i] == ".":
			t_dialog.text += f_dialog[i]
			await get_tree().create_timer(0.3).timeout
		elif f_dialog[i] == ",":
			t_dialog.text += f_dialog[i]
			await get_tree().create_timer(0.15).timeout
		else:
			t_dialog.text += f_dialog[i]
			$ta.playing = true
		
		await get_tree().create_timer(0.06).timeout
	
	if type == 50:
		await  get_tree().create_timer(600).timeout
	
	await  get_tree().create_timer(3).timeout
	talk.visible = false
	
	if type != 0:
		harpoon.visible = true
		harpoon.process_mode = Node.PROCESS_MODE_INHERIT
	

var caught_fishes = 0
var fish_color

func caught(col):
	caught_fishes += 1
	
	fish_color = col.get_child(0).color
	#var fish_color_2 = col.get_child(1).color
	#var fish_type = col.get_child(2).name
	
	
	if len(glov.fish_dialogs) != 0:
		var dialog = glov.fish_dialogs.pick_random()
		await talk_func("Fish", dialog , 2)
		glov.fish_dialogs.erase(dialog)
	else:
		pass

# Achievement Milestones
	if caught_fishes == 3:
		await talk_func("Void Master", "Have you ever found yourself lost in the labyrinth of your own thoughts?", 1)
	elif caught_fishes == 5:
		await talk_func("Void Master", "Do you believe that the essence of your being can be encapsulated in mere words?", 1)
	elif caught_fishes == 8:
		await talk_func("Void Master", "Consider this: every reflection you see is but a fragment of your true self.", 1)
	elif caught_fishes == 10:
		await talk_func("Void Master", "Have you ever considered the masks we wear, tailored to fit each social scenario?", 1)
		await talk_func("Void Master", "Indeed, the self we present to the world is a mere shadow of our inner complexities.", 1)
		await talk_func("CREATOR", "Hello It's me! I'm just wondering what makes a game a good game... I don't know yet!", 10)
		await  talk_func("CREATOR", "Exactly, how could I forget... People like statistics, they like everything they do being monitored... It seems strange to me... But oh well, I'll add a counter especially for you...", 10)
		$cl/mc.visible = true
		
	elif caught_fishes == 20:
		await talk_func("Void Master", "Contemplate the symphony of selves that coalesce within you, harmonizing in discordant unity.", 1)
		await talk_func("Void Master", "Do you perceive the resonance of their voices, echoing through the corridors of your consciousness?", 1)
		await talk_func("Void Master", "You've ensnared 20 souls in your ethereal net. How do you reconcile this ethereal bounty?", 1)
	elif caught_fishes == 25:
		await talk_func("Void Master", "A quarter-century of souls tethered to your existential plight...", 1)
		await talk_func("Void Master", "Yet, have you considered the toll exacted upon the cosmos by your voracious quest?", 1)
		await talk_func("Void Master", "Do you harbor remorse for the lives extinguished in the wake of your insatiable hunger?", 1)
		await talk_func("CREATOR", "Ah, the essence of a good game. It's more than just lines of code and pixels on a screen.", 10)
	elif caught_fishes == 35:
		await talk_func("Void Master", "Have you considered the ephemeral nature of consequence in this timeless expanse?", 1)
		await talk_func("Void Master", "Every action reverberates through the fabric of reality, leaving indelible marks upon the void.", 1)
		await talk_func("CREATOR", "It's about crafting an experience that transcends mere entertainment, leaving a lasting impression on the player's soul.", 10)
	elif caught_fishes == 50:
		await talk_func("Void Master", "Fifty! A milestone reached amidst the cosmic dance of existence.", 1)
		await talk_func("Void Master", "Yet, with each catch, do you draw closer to enlightenment or further into the abyss?", 1)
		glov.sat = 0.2
		await talk_func("CREATOR", "Nice achievement! Now I can return what I took...", 10)
	elif caught_fishes == 100:
		await talk_func("Void Master", "A century of catches in the boundless sea of nothingness.", 1)
		await talk_func("Void Master", "Yet, as you stand on the precipice of a hundred souls, do you perceive the fragmented shards of your identity converging into a singular whole?", 1)
		await talk_func("Void Master", "Or do you remain adrift in the nihilistic currents, forever fragmented and lost amidst the chaos of existence?", 1)
		await talk_func("CREATOR", "Wow you've come this far, you're catching and catching these fish, I'm glad you made it this far. Remember you are amazing!", 10)

	# Philosophical Reflections
	elif caught_fishes == 13:
		await talk_func("Void Master", "Are you aware of the kaleidoscope of identities you inhabit in the eyes of others?", 1)
		await talk_func("Void Master", "Perhaps therein lies the enigma of the self: a multifaceted prism, refracting perceptions.", 1)
		await talk_func("CREATOR", "A good game is a delicate balance of challenge and reward, keeping the player engaged without overwhelming them.", 10)
	elif caught_fishes == 16:
		await talk_func("Void Master", "Imagine yourself as a constellation, each star representing a facet of your being.", 1)
		await talk_func("Void Master", "Yet, like the stars, these facets converge to form the tapestry of your existence.", 1)
	elif caught_fishes == 18:
		await talk_func("Void Master", "Consider this paradox: the self is both an anchor and a vessel, simultaneously static and fluid.", 1)
	elif caught_fishes == 32:
		await talk_func("Void Master", "Do you ever ponder the possibility of alternate realities, branching forth from every decision made?", 1)
		await talk_func("Void Master", "Perhaps every fish caught represents a divergence in the tapestry of existence.", 1)
		await talk_func("CREATOR", "A truly exceptional game captivates the player's imagination, drawing them into a world of endless possibilities.", 10)
		await talk_func("CREATOR", "Do you think you can do more in this game?", 10)
		glov.sat = 0.5
		await talk_func("CREATOR", "I can, because I am its creator, I can make these fish have more life in them.", 10)
	elif caught_fishes == 37:
		await talk_func("Void Master", "What lies beyond the event horizon of your perception, concealed within the depths of the unknown?", 1)
		await talk_func("Nyx", "Ah, the mysteries of the cosmos, shrouded in darkness and secrecy. Do you dare to venture into the unknown, mortal?", 20)
		await talk_func("Evan", "I once thought I had all the time in the world to explore the unknown, but now I realize that time is a fleeting gift. Don't make the same mistake I did, my friends.", 40)
	elif caught_fishes == 38:
		await talk_func("Void Master", "Each fish ensnared adds to the burden of your cosmic ledger, a ledger bound by threads of fate.", 1)
		await talk_func("Aria", "But do not be burdened by the weight of destiny, for it is but a thread woven into the tapestry of existence. Embrace the flow of the cosmos, and find solace in the rhythm of life.", 30)
		await talk_func("Evan", "My ledger is filled with regrets and missed opportunities. I chased after fleeting pleasures and neglected the things that truly mattered.", 40)
	elif caught_fishes == 39:
		await talk_func("Void Master", "Do you find solace in the pursuit of purpose, or does the void stare back, unyielding and indifferent?", 1)
		await talk_func("Nyx", "Purpose... a fleeting notion in the vast expanse of eternity. Is it but a comforting illusion, masking the existential dread that lurks within?", 20)
	elif caught_fishes == 40:
		await talk_func("Void Master", "Have you ever felt the weight of solitude in this boundless abyss?", 1)
		await talk_func("Aria", "Solitude is not loneliness, but rather an opportunity for introspection and self-discovery. Embrace the solitude, and you may find the wisdom you seek.", 30)
		glov.sat = 0.05
		await talk_func("CREATOR", "No, no, no! There is too much life in these fishes now, let's fix it...", 10)
		await talk_func("Evan", "There is no solace in the void, only the echoes of my mistakes haunting me for eternity. Treasure each moment, for you never know when it will be your last.", 40)
	elif caught_fishes == 41:
		await talk_func("Void Master", "Contemplate the interplay of destiny and free will, woven into the fabric of your existence.", 1)
		await talk_func("Void Master", "Wait! What happened! CREATOR! Why are my fishes so faded!", 1)
		await talk_func("CREATOR", "Let them exist for a while, do you think the color makes them different? These are the same fishes as before, I just stole some of their life...", 10)
		await talk_func("Nyx", "Destiny... a concept as fluid as the rivers of time. Do we shape our fate, or are we mere actors in a cosmic play scripted by unseen hands?", 20)
	elif caught_fishes == 43:
		await talk_func("Void Master", "As you cast your line into the abyss, do you grasp the threads of destiny, or are you merely a pawn in a cosmic game?", 1)
		await talk_func("Evan", "Solitude is a prison I built for myself, shutting out those who cared for me in pursuit of selfish desires. Don't make the same mistake, my friends...", 40)
	elif caught_fishes == 46:
		await talk_func("Void Master", "What drives you to continue fishing in this endless sea of nothingness?", 1)
		await talk_func("Aria", "It is not the destination that drives us, but the journey itself. Embrace the act of fishing, and you may discover the true meaning of existence.", 30)
	elif caught_fishes == 47:
		await talk_func("Void Master", "Have you ever questioned the nature of reality in this surreal domain?", 1)
		await talk_func("CREATOR", "But perhaps most importantly, a good game resonates with emotion, evoking laughter, tears, and everything in between.", 10)
		await talk_func("Nyx", "Reality... a fragile veil draped over the chaos of the cosmos. Do you seek truth amidst the illusion, mortal?", 20)
	elif caught_fishes == 48:
		await talk_func("Void Master", "Do you believe in the existence of other beings beyond what we can perceive?", 1)
	elif caught_fishes == 52:
		await talk_func("Void Master", "As you reel in another catch, ponder the transient nature of existence amidst the infinite expanse of the void.", 1)
		await talk_func("Void Master", "For each fish ensnared echoes the fleeting moments of life, ephemeral yet profound.", 1)
		await talk_func("CREATOR", "It's the moments of triumph and defeat, the connections forged with characters, and the memories created along the journey.", 10)
	elif caught_fishes == 55:
		await talk_func("Void Master", "In the grand scheme of existence, do you find significance in the transient moments of your being?", 1)
		await talk_func("Void Master", "Or do they dissolve into the vast expanse of nothingness, devoid of purpose or meaning?", 1)
	elif caught_fishes == 60:
		await talk_func("Void Master", "As you reel in another catch, ponder the futility of your actions against the backdrop of eternity.", 1)
		await talk_func("Void Master", "For what is the value of your endeavors in a universe indifferent to your existence?", 1)
	elif caught_fishes == 65:
		await talk_func("Void Master", "Consider the paradox of identity: a construct shaped by the perceptions of others, yet devoid of inherent truth.", 1)
		await talk_func("Void Master", "Do you find solace or despair in the realization that your essence is but a mirage in the desert of nihilism?", 1)
		await talk_func("CREATOR", "Ultimately, a good game is a work of art, a symphony of design, storytelling, and gameplay that leaves players yearning for more.", 10)
	elif caught_fishes == 70:
		await talk_func("Void Master", "With each fish caught, do you peel back the layers of illusion surrounding your sense of self?", 1)
		await talk_func("Void Master", "Or do you merely add another mask to the ever-growing facade of your existence?", 1)
	elif caught_fishes == 75:
		await talk_func("Void Master", "As you navigate the labyrinth of your psyche, do you confront the abyss within, or do you seek refuge in ignorance?", 1)
		await talk_func("Void Master", "For in the emptiness of nihilism lies both despair and liberation, awaiting those brave enough to embrace them.", 1)
	elif caught_fishes == 80:
		await talk_func("Void Master", "Do you perceive the dichotomy between the self you present to the world and the void that lurks within?", 1)
		await talk_func("Void Master", "Or do you cling to the illusion of unity, oblivious to the fractured nature of your existence?", 1)
		await talk_func("CREATOR", "These fishes... They just appear out of your line of sight... As in life, you can't see everything.", 10)
	elif caught_fishes == 85:
		await talk_func("Void Master", "In the tapestry of your being, do you discern the threads of individuality or the seamless blend of disparate personas?", 1)
		await talk_func("Void Master", "For what is identity but a transient illusion, subject to the whims of perception and the passage of time?", 1)
	elif caught_fishes == 90:
		await talk_func("Void Master", "As you approach the zenith of your journey, contemplate the abyss that gazes back, indifferent to your plight.", 1)
		await talk_func("Void Master", "For in the depths of nihilism lies the crucible of self-discovery, where illusions shatter and truths emerge.", 1)
	elif caught_fishes == 95:
		await talk_func("Void Master", "With each fish ensnared in your existential net, do you glimpse the kaleidoscope of your being or the void that threatens to consume it?", 1)
		await talk_func("Void Master", "For in the dance between existence and oblivion, lies the essence of your fleeting humanity.", 1)
		await talk_func("CREATOR", "Why am I doing this game? Why am I writing all this, no one will get this far anyway...", 10)
	elif caught_fishes == 100:
		await talk_func("Void Master", "In the vast expanse of the cosmos, do you perceive reality as a construct of the mind or an immutable truth?", 1)
		await talk_func("Void Master", "For what is reality but a tapestry woven from the fabric of perception and the threads of existence?", 1)
		await talk_func("Void Master", "I feel like you already know too much... I have to eliminate you...", 1)
		harpoon.visible = false
		harpoon.process_mode = Node.PROCESS_MODE_DISABLED
		$cl/mc.visible = false
		$audio.playing = false
		$eye_anim/AnimationPlayer.play_backwards("open")
		await get_tree().create_timer(30).timeout
		await talk_func("<UNKNOWN>", "You waited here for 30 seconds even though the game was already over? Thank you so much for coming this far! Now leave, I have nothing more to offer. You've wasted so much time... so much time... Do something! Now!", 50)
		
