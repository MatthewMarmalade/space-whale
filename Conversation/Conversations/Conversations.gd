extends Object

var convos = {
FirstContact = ["> ??",
"Ow...",
"What...",
"...happened?",

"> ????",
"You're awake! Are you okay?",

"> ??",
"...",
"Mostly.",

"> ????",
"What are you doing all the way out here in this junk graveyard? No one comes here.",

"> ??",
"...",

"> ????",
"I saw your ship coming in, way too fast. You crashed into some old fuel tanks.",
"You're lucky to be alive. The explosion turned the whole sky white.",

"> ??",
"...",
"You saved me.",
"Who are you?",

"> ????",
"I'm a Leviathan-class star trawler.",
"#hiya BIG CAMERA SWOOSH LIKE OH MY GOD IT'S A WHALE",

"> HARBOR",
"My old captain called me Harbor, but...he's not around anymore.",
"I've been floating in this junkyard for a while. No one comes here.",

"> ??",
"I came here.",

"> HARBOR",
"And now you're stuck too. No ship, let alone any fuel...",
"Well, unless...are you any good at fishing?",

"> ??",
"Sure.",

"> HARBOR",
"See the harpoon rigged up there? That's how the captain used to fish for me. If you catch enough for me to eat, I can fly us out of here.",
],
FeedAny = ["> HARBOR",
"That's much better. Oh, I missed flying... Thank you. Thank you so much!",

"> ??",
"Mm hm.",

"> HARBOR",
"I was thinking...since you lost your ship, and I have no captain...",
"Would you like to stay?",
"Fishing isn't a bad way to make a living. At least, I think so.",

"> ??",
"Hmm.",
"...",
"Okay.",

"> HARBOR",
"Oh! Really? Just like that?",

"> ??",
"Sure.",

"> HARBOR",
"Thank you.",
"...",
"I think we'll make a good crew.",
],
Convo3 = ["> HARBOR",
"I just realized that I don't know what to call you.",

"> ??",
"Hm?",

"> HARBOR",
"You know my name, but I don't know yours.",

"> ??",
"...",

"> HARBOR",
"What should I call you?",

"> ??",
"...",
"...",
"...",
"Dunno.",

"> HARBOR",
"Oh, no, did you get hit when your ship exploded? Do you remember your name?",

"> ??",
"I'm fine.",
"I remember.",

"> HARBOR",
"Oh.",
"Well...what would you like me to call you?",

"> ??",
"Don't care.",
],
Convo4 = ["> HARBOR",
"Would you mind if I gave you a nickname?",
"I can't just call you captain.",
"Everyone deserves a name.",

"> ??",
"That's fine.",

"> HARBOR",
"Okay! Hm...",
"...",
"Can I call you...Hush?",

"> ??",
"Ha.",
"That's fair.",

"> HARBOR",
"You like it?",

"> HUSH",
"Mm hm.",
],

Convo5 = ["> INTER-SYSTEM RADIO BROADCAST",
"THIS IS AN ALERT FROM THE BUREAU OF INTER-SYSTEM JUSTICE.",
"YOU ARE ENTERING TERRITORY WHERE PIRATES ARE KNOWN TO BE ACTIVE.",
"REMAIN VIGILANT AND REPORT ANY SIGHTINGS TO—",

"> HUSH",
"Shh.",

"> HARBOR",
"Was that something on the radio? What did it say?",

"> HUSH",
"Nothing.",
],

Convo6 = ["> HARBOR",
"Hush, is it all right if I ask you a question?",

"> HUSH",
"Mm hm.",

"> HARBOR",
"There's an oxygen field on deck, you know. You don't need to wear your suit while you're on board.",

"> HUSH",
"That's not a question.",

"> HARBOR",
"Oh. Oh, well, I just mean...",
"Why do you wear it, then?",

"> HUSH",
"...",
"In case something goes wrong.",

"> HARBOR",
"I won't let anything happen to you.",

"> HUSH",
"...",
],
Convo7 = ["> INTER-SYSTEM RADIO BROADCAST",
"THIS IS A SECURITY BULLETIN. THE BUREAU OF INTER-SYSTEM JUSTICE REMAINS ON THE LOOKOUT FOR A FUGITIVE KNOWN TO BE ACTIVE IN THIS TERRITORY.",
"MAUREEN AGATHA PIC IS WANTED FOR PIRACY AND EVASION OF JUSTICE—",

"> HUSH",
"Shh!",

"> INTER-SYSTEM RADIO BROADCAST",
"—LAST SEEN FLEEING TO THE OUTER TERRITORIES IN A STOLEN, DECOMMISSIONED TRANSPORT VESSEL—",

"> HARBOR",
"Do you know what they're talking about?",

"> HUSH",
"SH!",

"> ...",
"(Hush smashes the radio.)",
],
Convo8 = ["> HUSH",
"Harbor?",
"I'm sorry.",
"I fixed it.",

"> HARBOR",
"You said you wouldn't leave me.",

"> HUSH",
"I'm still here.",
"I just needed...quiet.",
"I'm sorry.",

"HARBOR",
"Who is Maureen?",

"HUSH",
"...",
"Me.",
"Well. Used to be me.",
"Don't like that name anymore.",
"Don't wanna talk about it.",

"> HARBOR",
"...",
"Okay.",
"Just...don't do that again.",

"> HUSH",
"I'll try.",
],
Convo9 = ["> RADIO",
"[KSHHHKSHHKHS]",

"> HUSH",
"Come on.",

"> HARBOR",
"Why can't you leave the radio alone?",

"HUSH",
"...",

"> ERROR ERROR BROADCAST ORIGIN UNKNOWN",
"—the Bureau has tightened security at the border of the inner systems, best steer clear until it all blows over.",

"HUSH",
"I'm trying to find the right frequency.",
"The ones my friends used to use.",
"I want to know if they miss me.",
"...",
"I want to know if they're sorry.",

"> HARBOR",
"...",
"What were you doing in that junkyard, Hush?",

"> HUSH",
"Running away.",
"I was a pirate, but...",
"I got caught.",
"My friends sold me out.",
"To save their own skins.",
"I got away on that ship, but...",
"You saw what happened.",

"> ERROR ERROR BROADCAST ORIGIN UNKNOWN",
"Be careful transporting any contraband. The open offer of 15,000 credits [KSHSSKHHSSHSS] is still—",

"HUSH",
"Shh...",
"Quiet now.",
"I don't think I care anymore.",
"Not really.",
"Quiet's not so bad.",
],
Convo10 = ["> HARBOR",
"Hush?",

"> HUSH",
"Mm?",

"> HARBOR",
"I'm sorry for what happened to you.",

"> HUSH",
"‘S not your fault.",

"> HARBOR",
"I don't care. Someone should be sorry. So it might as well be me.",

"> HUSH",
"Thanks, Harbor.",
"...",
"Thank you.",

"> HARBOR",
"Hush?",

"> HUSH",
"Mm?",

"> HARBOR",
"You changed your name, right? Because you wanted to be someone new?",

"> HUSH",
"I guess so.",

"> HARBOR",
"I don't want to be what my captain wanted me to be, anymore. Should I change my name?",

"> HUSH",
"Do you wanna?",

"> HARBOR",
"...",
"I don't think so.",
"I don't care about him, but…I like being Harbor.",
"I like getting to be a harbor. For someone like you.",
"...",
"I'm glad you stayed.",

"HUSH",
"'Course.",
"Nowhere I'd rather be.",
],

CatchRed = ["> HARBOR",
"Oh, Architeuthis solaris! What a beauty. They usually live inside stars, you know, riding the convection currents.",
"Isn't that lovely? Just like they're sailing on sunlight.",
],
CatchGreen = ["> HARBOR",
"Oh, my! Muraena borealis. There's really nothing else like it...well, I suppose there is, actually.",
"They glow just like the lights they're named after. Have you ever seen an aurora?",
"All that light dancing, blown around by solar wind...it sounds beautiful!",
],
CatchBlue = ["> HARBOR",
"That is a beautiful Micropterus occasus! I know they don't look it, but they're actually a type of sun fish. Just not so hot or bright. Which makes them much safer to eat!",
],
CatchPurple = ["> HARBOR",
"Good catch! That's an Oncorhynchus vacuus. They're quite common, but no less interesting! When it's time to spawn, they can always find their way back to their home star. No matter how far they wander.",
],
CatchGold = ["> HARBOR",
"By the stars! Would you look at that! Coelacanthus sidereus. You don't see those very often!",
"Did you know, for hundreds of years, everyone thought they'd gone extinct?",

"> HUSH",
"Mm.",

"> HARBOR",
"It seems they're better survivors than anyone counted on.",
"...",
"Kind of like us.",

],

FeedAnyLater0 = ["> HARBOR",
"Thank you.",
],
FeedAnyLater1 = ["> HARBOR",
"Much appreciated.",
],
FeedAnyLater2 = ["> HARBOR",
"Mm! That was a good catch."
],
}
