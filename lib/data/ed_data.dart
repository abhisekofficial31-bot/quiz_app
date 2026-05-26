import '../models/ed_model.dart';

// ─────────────────────────────────────────────────────────────────────────────
// NCERT CLASS 1 — EVS (Looking Around / Aas Paas) + MATHS (Magic of Mathematics)
// Each chapter → real NCERT sub-topics → 10 questions each
// Simple language, 3 options, 45 sec timer — designed for 6-7 year olds
// ─────────────────────────────────────────────────────────────────────────────

class EdData {

  // ══════════════════════════════════════════════════════════════════════════
  // NCERT CLASS 1 — EVS "Looking Around"
  // Chapters: 1.My Body  2.My Family  3.My Home  4.My School
  //           5.Food     6.Animals   7.Plants   8.Water
  //           9.Weather 10.Transport
  // ══════════════════════════════════════════════════════════════════════════

  static const SchoolSubject _evs = SchoolSubject(
    id: 'class1_evs',
    name: 'EVS',
    emoji: '🌿',
    color: Color(0xFF2ECC71),
    description: 'Looking Around — our body, family, home & nature',
    chapters: [

      // ── Chapter 1: My Body ─────────────────────────────────────────────
      SchoolChapter(
        chapterNumber: 1,
        title: 'My Body',
        emoji: '🧍',
        summary: 'Learn about body parts and their uses',
        subTopics: [
          SubTopic(
            topicNumber: 1,
            title: 'Parts of the Body',
            emoji: '👁️',
            questions: [
              EdQuestion(question: 'How many eyes do we have?', options: ['One', 'Two', 'Three'], correctIndex: 1, explanation: 'We have two eyes to see things around us.', funFact: 'Our eyes can see millions of colours!'),
              EdQuestion(question: 'Which part of the body do we use to smell?', options: ['Eyes', 'Nose', 'Ears'], correctIndex: 1, explanation: 'We use our nose to smell things.', funFact: 'We can smell over 10,000 different smells!'),
              EdQuestion(question: 'Which part do we use to hear sounds?', options: ['Ears', 'Mouth', 'Hands'], correctIndex: 0, explanation: 'We use our ears to hear sounds.', funFact: 'Ears also help us to balance!'),
              EdQuestion(question: 'How many hands do we have?', options: ['One', 'Three', 'Two'], correctIndex: 2, explanation: 'We have two hands to hold and do work.', funFact: 'Each hand has 27 bones!'),
              EdQuestion(question: 'Which part do we use to taste food?', options: ['Nose', 'Tongue', 'Eyes'], correctIndex: 1, explanation: 'We use our tongue to taste sweet, sour, salty and bitter food.', funFact: 'We have about 10,000 taste buds on our tongue!'),
              EdQuestion(question: 'How many legs do we have?', options: ['Two', 'Four', 'One'], correctIndex: 0, explanation: 'We have two legs to walk and run.', funFact: 'Our legs are the strongest part of our body!'),
              EdQuestion(question: 'Which part of the body do we use to think?', options: ['Heart', 'Brain', 'Stomach'], correctIndex: 1, explanation: 'Our brain helps us to think, remember and learn.', funFact: 'Our brain never stops working, even when we sleep!'),
              EdQuestion(question: 'Which part do we use to speak?', options: ['Mouth', 'Ear', 'Eye'], correctIndex: 0, explanation: 'We use our mouth to speak and eat.', funFact: 'Babies learn to speak by listening to their parents!'),
              EdQuestion(question: 'How many fingers are on one hand?', options: ['Four', 'Six', 'Five'], correctIndex: 2, explanation: 'We have five fingers on each hand.', funFact: 'Each finger has a unique fingerprint!'),
              EdQuestion(question: 'Which body part pumps blood?', options: ['Lungs', 'Heart', 'Brain'], correctIndex: 1, explanation: 'Our heart pumps blood to all parts of the body.', funFact: 'Your heart beats about 100,000 times every day!'),
            ],
          ),
          SubTopic(
            topicNumber: 2,
            title: 'Senses',
            emoji: '👃',
            questions: [
              EdQuestion(question: 'How many senses do we have?', options: ['Three', 'Four', 'Five'], correctIndex: 2, explanation: 'We have five senses — sight, hearing, smell, taste and touch.', funFact: 'Some animals have more senses than us!'),
              EdQuestion(question: 'Which sense helps us see colours?', options: ['Touch', 'Sight', 'Smell'], correctIndex: 1, explanation: 'Our sense of sight (eyes) helps us see colours and shapes.', funFact: 'Dogs cannot see as many colours as humans!'),
              EdQuestion(question: 'Which sense tells us if something is hot or cold?', options: ['Sight', 'Hearing', 'Touch'], correctIndex: 2, explanation: 'Our sense of touch (skin) tells us if something is hot, cold, rough or smooth.', funFact: 'Our skin has millions of tiny sensors!'),
              EdQuestion(question: 'What do we use to see?', options: ['Ears', 'Eyes', 'Nose'], correctIndex: 1, explanation: 'We use our eyes to see everything around us.', funFact: 'Eyes can process 36,000 bits of information every hour!'),
              EdQuestion(question: 'What do we use to hear music?', options: ['Eyes', 'Nose', 'Ears'], correctIndex: 2, explanation: 'We use our ears to hear sounds and music.', funFact: 'Elephants can hear sounds from very far away!'),
              EdQuestion(question: 'Which sense do we use to smell flowers?', options: ['Taste', 'Smell', 'Touch'], correctIndex: 1, explanation: 'We use our sense of smell (nose) to smell flowers and food.', funFact: 'Bees find flowers using their sense of smell!'),
              EdQuestion(question: 'Which sense do we use to taste an apple?', options: ['Touch', 'Hearing', 'Taste'], correctIndex: 2, explanation: 'We use our sense of taste (tongue) to taste food.', funFact: 'Sweet taste buds are at the tip of our tongue!'),
              EdQuestion(question: 'A blind person cannot:', options: ['Hear sounds', 'See things', 'Taste food'], correctIndex: 1, explanation: 'A blind person cannot see. They use other senses more strongly.', funFact: 'Blind people can read using Braille — raised dots they feel with fingers!'),
              EdQuestion(question: 'What organ do we use for touch?', options: ['Eyes', 'Skin', 'Ears'], correctIndex: 1, explanation: 'Our skin is the organ we use for touch.', funFact: 'Skin is the largest organ of our body!'),
              EdQuestion(question: 'If we close our eyes, we cannot:', options: ['Hear', 'See', 'Smell'], correctIndex: 1, explanation: 'When we close our eyes we cannot see things.', funFact: 'Even with eyes closed, we can sense light!'),
            ],
          ),
          SubTopic(
            topicNumber: 3,
            title: 'Keeping Clean',
            emoji: '🛁',
            questions: [
              EdQuestion(question: 'How often should we brush our teeth?', options: ['Once a week', 'Twice a day', 'Once a month'], correctIndex: 1, explanation: 'We should brush our teeth twice a day — morning and night.', funFact: 'Brushing for 2 minutes removes the most germs!'),
              EdQuestion(question: 'We should wash our hands:', options: ['Only before sleeping', 'Before eating food', 'Only after playing'], correctIndex: 1, explanation: 'We must wash our hands before eating to keep away germs.', funFact: 'Washing hands for 20 seconds kills most germs!'),
              EdQuestion(question: 'What do we use to clean our body?', options: ['Sand', 'Soap and water', 'Mud'], correctIndex: 1, explanation: 'We use soap and water to clean our body and stay healthy.', funFact: 'Soap was invented over 5000 years ago!'),
              EdQuestion(question: 'We should cut our nails:', options: ['When they are dirty', 'Regularly', 'Never'], correctIndex: 1, explanation: 'We should cut our nails regularly to keep them clean.', funFact: 'Nails grow about 3mm every month!'),
              EdQuestion(question: 'What should we do after using the toilet?', options: ['Wash hands', 'Eat food', 'Play'], correctIndex: 0, explanation: 'We must always wash our hands after using the toilet.', funFact: 'Germs are too small to see but can make us sick!'),
              EdQuestion(question: 'We should bathe:', options: ['Once a week', 'Every day', 'Once a month'], correctIndex: 1, explanation: 'We should bathe every day to stay clean and fresh.', funFact: 'Bathing removes about 2 million germs!'),
              EdQuestion(question: 'What do we use to clean our teeth?', options: ['Finger', 'Toothbrush', 'Cloth'], correctIndex: 1, explanation: 'We use a toothbrush and toothpaste to clean our teeth.', funFact: 'The first toothbrush was made from animal hair!'),
              EdQuestion(question: 'Dirty hands can cause:', options: ['Happiness', 'Sickness', 'Growth'], correctIndex: 1, explanation: 'Dirty hands carry germs that can make us sick.', funFact: 'Germs can live on hands for up to 3 hours!'),
              EdQuestion(question: 'We should wash our hair:', options: ['Every month', 'Regularly', 'Never'], correctIndex: 1, explanation: 'We should wash our hair regularly to keep it clean and healthy.', funFact: 'Our hair grows about 15cm every year!'),
              EdQuestion(question: 'Which of these keeps us healthy?', options: ['Eating dirty food', 'Drinking clean water', 'Playing in mud only'], correctIndex: 1, explanation: 'Drinking clean water keeps us healthy and free from diseases.', funFact: 'Our body is made of about 60% water!'),
            ],
          ),
        ],
      ),

      // ── Chapter 2: My Family ───────────────────────────────────────────
      SchoolChapter(
        chapterNumber: 2,
        title: 'My Family',
        emoji: '👨‍👩‍👧‍👦',
        summary: 'Learn about family members and relationships',
        subTopics: [
          SubTopic(
            topicNumber: 1,
            title: 'Family Members',
            emoji: '👪',
            questions: [
              EdQuestion(question: 'Who is your mother\'s mother?', options: ['Aunt', 'Grandmother', 'Sister'], correctIndex: 1, explanation: 'Your mother\'s mother is called your grandmother (Nani/Dadi).', funFact: 'Grandparents have lots of stories to share!'),
              EdQuestion(question: 'Who is the father of your father?', options: ['Uncle', 'Grandfather', 'Brother'], correctIndex: 1, explanation: 'Your father\'s father is your grandfather (Dada).', funFact: 'In India we call grandfather Dada or Nana!'),
              EdQuestion(question: 'What do we call our parents\' sister?', options: ['Aunt', 'Grandmother', 'Mother'], correctIndex: 0, explanation: 'Our parents\' sister is our aunt (Chachi, Bua, Mausi, Mami).', funFact: 'In India we have many special names for relatives!'),
              EdQuestion(question: 'A family that has grandparents, parents and children is called:', options: ['Small family', 'Joint family', 'Single family'], correctIndex: 1, explanation: 'A joint family has grandparents, parents, uncles, aunts and children all living together.', funFact: 'India has many joint families!'),
              EdQuestion(question: 'Who takes care of us when we are sick?', options: ['Strangers', 'Our family', 'Nobody'], correctIndex: 1, explanation: 'Our family loves and takes care of us when we are sick.', funFact: 'Family is one of our greatest strengths!'),
              EdQuestion(question: 'What do we call our father\'s brother?', options: ['Grandfather', 'Uncle', 'Brother'], correctIndex: 1, explanation: 'Our father\'s brother is our uncle (Chacha/Tau/Mama/Fufa).', funFact: 'India has specific names for each type of uncle!'),
              EdQuestion(question: 'Who are the children of the same parents?', options: ['Friends', 'Neighbours', 'Siblings'], correctIndex: 2, explanation: 'Children of the same parents are called siblings — brothers and sisters.', funFact: 'Twins are siblings born on the same day!'),
              EdQuestion(question: 'A family with only mother, father and one or two children is called:', options: ['Joint family', 'Nuclear family', 'Big family'], correctIndex: 1, explanation: 'A nuclear family has only parents and their children.', funFact: 'Nuclear families are becoming more common in cities!'),
              EdQuestion(question: 'Who is the female parent in a family?', options: ['Sister', 'Mother', 'Aunt'], correctIndex: 1, explanation: 'The mother is the female parent who loves and cares for her children.', funFact: 'Mothers are celebrated every year on Mother\'s Day!'),
              EdQuestion(question: 'Who is the male parent in a family?', options: ['Uncle', 'Brother', 'Father'], correctIndex: 2, explanation: 'The father is the male parent who loves and supports his family.', funFact: 'Fathers are celebrated on Father\'s Day every year!'),
            ],
          ),
          SubTopic(
            topicNumber: 2,
            title: 'Helping at Home',
            emoji: '🏠',
            questions: [
              EdQuestion(question: 'Which of these can children do to help at home?', options: ['Cook on fire', 'Keep their room tidy', 'Drive car'], correctIndex: 1, explanation: 'Children can help at home by keeping their room tidy and organised.', funFact: 'Helping at home makes everyone happy!'),
              EdQuestion(question: 'Who usually cooks food at home?', options: ['Pet animals', 'Family members', 'Teachers'], correctIndex: 1, explanation: 'Family members cook food at home for everyone.', funFact: 'Cooking is a very useful skill to learn!'),
              EdQuestion(question: 'Why should we help our family?', options: ['To get money', 'To show love and care', 'To watch TV'], correctIndex: 1, explanation: 'Helping family shows love and care and makes our home happy.', funFact: 'Families that help each other are stronger!'),
              EdQuestion(question: 'What should you do with your toys after playing?', options: ['Leave them anywhere', 'Put them back in place', 'Throw them away'], correctIndex: 1, explanation: 'We should put our toys back in their place after playing.', funFact: 'Keeping things tidy saves time finding them later!'),
              EdQuestion(question: 'How can you help when a family member is sick?', options: ['Ignore them', 'Ask if they need water or medicine', 'Go out and play'], correctIndex: 1, explanation: 'We should ask sick family members if they need help, water, or medicine.', funFact: 'Even small acts of kindness help sick people feel better!'),
              EdQuestion(question: 'What should we do with dirty clothes?', options: ['Keep them on the floor', 'Put them in the laundry basket', 'Hide them under the bed'], correctIndex: 1, explanation: 'We should put dirty clothes in the laundry basket.', funFact: 'Clean clothes help keep us healthy!'),
              EdQuestion(question: 'After eating food we should:', options: ['Leave dishes on the table', 'Help clear the table', 'Go to sleep immediately'], correctIndex: 1, explanation: 'After eating we should help clear the table and wash our plate.', funFact: 'Many hands make light work!'),
              EdQuestion(question: 'We should water plants at home because:', options: ['Plants like being wet', 'Plants need water to grow', 'Water is fun to pour'], correctIndex: 1, explanation: 'Plants need water to grow and stay green and healthy.', funFact: 'Plants make our home look beautiful and clean the air!'),
              EdQuestion(question: 'Which of these is a good habit at home?', options: ['Wasting food', 'Saving electricity', 'Leaving taps running'], correctIndex: 1, explanation: 'Saving electricity by switching off lights when not needed is a good habit.', funFact: 'Saving electricity helps our environment!'),
              EdQuestion(question: 'What should we say when someone helps us?', options: ['Nothing', 'Thank you', 'Go away'], correctIndex: 1, explanation: 'We should always say Thank You when someone helps us.', funFact: 'Saying thank you makes others feel appreciated!'),
            ],
          ),
        ],
      ),

      // ── Chapter 3: My Home ─────────────────────────────────────────────
      SchoolChapter(
        chapterNumber: 3,
        title: 'My Home',
        emoji: '🏡',
        summary: 'Different types of homes and rooms in a house',
        subTopics: [
          SubTopic(
            topicNumber: 1,
            title: 'Types of Homes',
            emoji: '🏘️',
            questions: [
              EdQuestion(question: 'What is the home made of straw and mud called?', options: ['Bungalow', 'Kutcha house', 'Palace'], correctIndex: 1, explanation: 'A kutcha house is made of mud, straw and leaves. It is a temporary home.', funFact: 'Many people in villages still live in kutcha houses!'),
              EdQuestion(question: 'What is a home made of bricks and cement called?', options: ['Kutcha house', 'Pucca house', 'Tent'], correctIndex: 1, explanation: 'A pucca house is made of bricks and cement. It is strong and long-lasting.', funFact: 'Pucca means "strong and permanent" in Hindi!'),
              EdQuestion(question: 'Where do people live in very cold places?', options: ['Tent', 'Igloo', 'Houseboat'], correctIndex: 1, explanation: 'People in very cold snowy places like the Arctic live in igloos made of ice.', funFact: 'Igloos are actually warm inside even though they are made of ice!'),
              EdQuestion(question: 'What do people who move from place to place live in?', options: ['Palace', 'Tent', 'Apartment'], correctIndex: 1, explanation: 'Nomads who move from place to place live in tents that can be set up quickly.', funFact: 'Some tribes in Rajasthan still move with tents!'),
              EdQuestion(question: 'What is a house that floats on water called?', options: ['Houseboat', 'Submarine', 'Ship'], correctIndex: 0, explanation: 'A houseboat is a home that floats on water. People in Kerala and Kashmir live in houseboats.', funFact: 'Dal Lake in Kashmir has famous houseboats!'),
              EdQuestion(question: 'Why do we need a home?', options: ['To store toys', 'For shelter, safety and rest', 'To show to others'], correctIndex: 1, explanation: 'A home gives us shelter from rain, cold and heat, and keeps us safe.', funFact: 'Every animal also has its own home or shelter!'),
              EdQuestion(question: 'People living in cities mostly live in:', options: ['Tents', 'Flats/Apartments', 'Igloos'], correctIndex: 1, explanation: 'In cities, many people live in flats or apartments in tall buildings.', funFact: 'The tallest building in the world has over 160 floors!'),
              EdQuestion(question: 'What is a very large and grand home called?', options: ['Hut', 'Tent', 'Palace'], correctIndex: 2, explanation: 'A palace is a very large and grand home where kings and queens live.', funFact: 'India has many beautiful palaces like those in Rajasthan!'),
              EdQuestion(question: 'Which material makes the strongest house?', options: ['Leaves', 'Bricks and cement', 'Straw'], correctIndex: 1, explanation: 'Bricks and cement make the strongest and most durable homes.', funFact: 'Some brick buildings are over 1000 years old!'),
              EdQuestion(question: 'An animal\'s home is called:', options: ['A school', 'A shelter/den', 'A market'], correctIndex: 1, explanation: 'Animals have their own homes called dens, nests, burrows or shelters.', funFact: 'Birds build nests, lions live in dens, and rabbits live in burrows!'),
            ],
          ),
          SubTopic(
            topicNumber: 2,
            title: 'Rooms in a House',
            emoji: '🛋️',
            questions: [
              EdQuestion(question: 'In which room do we sleep?', options: ['Kitchen', 'Bedroom', 'Bathroom'], correctIndex: 1, explanation: 'We sleep and rest in the bedroom.', funFact: 'A good night\'s sleep helps our brain grow stronger!'),
              EdQuestion(question: 'In which room do we cook food?', options: ['Bedroom', 'Living room', 'Kitchen'], correctIndex: 2, explanation: 'Food is cooked in the kitchen.', funFact: 'The kitchen is one of the most important rooms in a house!'),
              EdQuestion(question: 'In which room do we bathe?', options: ['Kitchen', 'Bathroom', 'Bedroom'], correctIndex: 1, explanation: 'We bathe and wash in the bathroom.', funFact: 'Ancient Romans had very large public bathrooms called "therme"!'),
              EdQuestion(question: 'In which room do we sit and watch TV?', options: ['Bedroom', 'Kitchen', 'Living room'], correctIndex: 2, explanation: 'We sit, relax, and watch TV in the living room.', funFact: 'Living rooms are called drawing rooms in some countries!'),
              EdQuestion(question: 'Where do we store and eat food?', options: ['Bathroom', 'Dining room and kitchen', 'Bedroom'], correctIndex: 1, explanation: 'Food is prepared in the kitchen and eaten in the dining room.', funFact: 'In some homes the kitchen and dining room are one room!'),
              EdQuestion(question: 'Where do we keep our clothes?', options: ['Kitchen', 'In a wardrobe in the bedroom', 'In the bathroom'], correctIndex: 1, explanation: 'We keep our clothes in a wardrobe or cupboard in the bedroom.', funFact: 'The word "wardrobe" comes from the French word for clothes!'),
              EdQuestion(question: 'What do we do in the study room?', options: ['Cook food', 'Read and study', 'Bathe'], correctIndex: 1, explanation: 'We read, write and study in the study room.', funFact: 'Having a special place to study helps you concentrate better!'),
              EdQuestion(question: 'Where should we keep our shoes?', options: ['In the bedroom', 'At the door or shoe rack', 'In the kitchen'], correctIndex: 1, explanation: 'Shoes should be kept at the door or on a shoe rack to keep the house clean.', funFact: 'In Japan it is a tradition to remove shoes before entering a home!'),
              EdQuestion(question: 'Which room has a stove or gas for cooking?', options: ['Bedroom', 'Living room', 'Kitchen'], correctIndex: 2, explanation: 'The kitchen has a stove or gas burner for cooking food.', funFact: 'The first kitchens were just open fires outside!'),
              EdQuestion(question: 'Where do guests usually sit when they visit us?', options: ['Bathroom', 'Kitchen', 'Living room'], correctIndex: 2, explanation: 'Guests are welcomed and seated in the living room.', funFact: 'Welcoming guests is an important tradition in Indian culture!'),
            ],
          ),
        ],
      ),

      // ── Chapter 4: My School ───────────────────────────────────────────
      SchoolChapter(
        chapterNumber: 4,
        title: 'My School',
        emoji: '🏫',
        summary: 'Learn about school, classrooms and school helpers',
        subTopics: [
          SubTopic(
            topicNumber: 1,
            title: 'People at School',
            emoji: '👩‍🏫',
            questions: [
              EdQuestion(question: 'Who teaches us at school?', options: ['Doctor', 'Teacher', 'Farmer'], correctIndex: 1, explanation: 'Teachers teach us lessons and help us learn at school.', funFact: 'Teachers\' Day is celebrated on 5th September in India!'),
              EdQuestion(question: 'Who helps keep our school clean?', options: ['Principal', 'Sweeper/Peon', 'Doctor'], correctIndex: 1, explanation: 'The sweeper or peon helps keep our school clean and tidy.', funFact: 'A clean school helps us study better!'),
              EdQuestion(question: 'Who is the head of the school?', options: ['Teacher', 'Principal', 'Peon'], correctIndex: 1, explanation: 'The principal is the head of the school and takes care of everything.', funFact: 'Principal means "main teacher" or "head person"!'),
              EdQuestion(question: 'Who guards our school gate?', options: ['Cook', 'Guard/Watchman', 'Teacher'], correctIndex: 1, explanation: 'The guard or watchman keeps our school safe at the gate.', funFact: 'School guards help make sure only safe people enter!'),
              EdQuestion(question: 'Who prepares our school meals?', options: ['Teacher', 'Cook', 'Driver'], correctIndex: 1, explanation: 'The cook prepares mid-day meals in schools.', funFact: 'India has one of the largest school meal programmes in the world!'),
              EdQuestion(question: 'What do we call children who study at the same school?', options: ['Family', 'Schoolmates/Classmates', 'Strangers'], correctIndex: 1, explanation: 'Children who study at the same school are called schoolmates or classmates.', funFact: 'Friends made at school can be friends for life!'),
              EdQuestion(question: 'Who drives the school bus?', options: ['Teacher', 'Bus driver', 'Principal'], correctIndex: 1, explanation: 'The bus driver drives the school bus safely.', funFact: 'School buses are always yellow so they are easy to see!'),
              EdQuestion(question: 'What does a librarian do?', options: ['Cooks food', 'Takes care of books in the library', 'Guards the gate'], correctIndex: 1, explanation: 'The librarian takes care of books in the school library.', funFact: 'Libraries have thousands of books waiting to be read!'),
              EdQuestion(question: 'We should respect all school helpers because:', options: ['They are paid', 'They all help make our school a good place', 'They are older'], correctIndex: 1, explanation: 'All school helpers do important jobs that make our school clean, safe and happy.', funFact: 'Every job is important — no job is small!'),
              EdQuestion(question: 'Who helps us if we are hurt at school?', options: ['Librarian', 'Guard', 'School nurse or teacher'], correctIndex: 2, explanation: 'The school nurse or teacher helps us if we are hurt or feeling unwell.', funFact: 'First aid kits help treat small injuries quickly!'),
            ],
          ),
          SubTopic(
            topicNumber: 2,
            title: 'School Rules and Things',
            emoji: '📚',
            questions: [
              EdQuestion(question: 'What should we do when our teacher is speaking?', options: ['Talk to friends', 'Listen quietly', 'Go to sleep'], correctIndex: 1, explanation: 'We should listen quietly when our teacher is speaking.', funFact: 'Listening carefully helps us learn and remember better!'),
              EdQuestion(question: 'What do we use to write in school?', options: ['Sticks', 'Pencil and pen', 'Fingers only'], correctIndex: 1, explanation: 'We use pencils and pens to write in our notebooks.', funFact: 'Pencils can draw a line 56 km long before running out!'),
              EdQuestion(question: 'Why should we not waste food in school?', options: ['It tastes bad', 'Food is precious and others may be hungry', 'It is expensive'], correctIndex: 1, explanation: 'Food is precious. We should not waste it as many children do not have enough food.', funFact: 'Farmers work very hard to grow our food!'),
              EdQuestion(question: 'What should we do if we want to ask a question in class?', options: ['Shout the answer', 'Raise our hand', 'Run to the teacher'], correctIndex: 1, explanation: 'We should raise our hand politely before speaking in class.', funFact: 'Asking questions is the best way to learn!'),
              EdQuestion(question: 'What should we not do to school property?', options: ['Use it carefully', 'Damage or break it', 'Keep it clean'], correctIndex: 1, explanation: 'We should never damage or break school property. We should take good care of it.', funFact: 'School property belongs to all students!'),
              EdQuestion(question: 'Where should we throw waste papers and wrappers?', options: ['On the floor', 'In the dustbin', 'Out of the window'], correctIndex: 1, explanation: 'We should always throw waste in the dustbin to keep our school clean.', funFact: 'A clean school is a happy school!'),
              EdQuestion(question: 'What should we carry in our school bag?', options: ['Food only', 'Books, notebooks and pencil box', 'Toys only'], correctIndex: 1, explanation: 'We should carry our books, notebooks, and pencil box to school every day.', funFact: 'Being prepared helps us learn better!'),
              EdQuestion(question: 'Why should we come to school on time?', options: ['To play more', 'So we don\'t miss any lessons', 'Because teachers like it'], correctIndex: 1, explanation: 'Coming to school on time means we don\'t miss any important lessons.', funFact: 'Being punctual is a good habit for life!'),
              EdQuestion(question: 'What should we do during the school prayer?', options: ['Talk to friends', 'Stand quietly and attentively', 'Eat snacks'], correctIndex: 1, explanation: 'During school prayer we should stand quietly and respectfully.', funFact: 'School prayer brings all students together!'),
              EdQuestion(question: 'What should we say to greet our teacher?', options: ['Nothing', 'Good morning / Good afternoon teacher', 'Bye-bye'], correctIndex: 1, explanation: 'We should greet our teacher with "Good morning" or "Good afternoon" respectfully.', funFact: 'Greetings are a sign of good manners!'),
            ],
          ),
        ],
      ),

      // ── Chapter 5: Plants Around Us ────────────────────────────────────
      SchoolChapter(
        chapterNumber: 5,
        title: 'Plants Around Us',
        emoji: '🌱',
        summary: 'Learn about plants, their parts and uses',
        subTopics: [
          SubTopic(
            topicNumber: 1,
            title: 'Parts of a Plant',
            emoji: '🌿',
            questions: [
              EdQuestion(question: 'Which part of a plant is under the soil?', options: ['Leaves', 'Roots', 'Flowers'], correctIndex: 1, explanation: 'Roots are under the soil. They take in water and minerals for the plant.', funFact: 'Some tree roots can go 60 metres deep into the ground!'),
              EdQuestion(question: 'Which part of a plant makes food using sunlight?', options: ['Roots', 'Stem', 'Leaves'], correctIndex: 2, explanation: 'Leaves make food for the plant using sunlight, water and air in a process called photosynthesis.', funFact: 'Leaves are like tiny solar panels for plants!'),
              EdQuestion(question: 'Which part holds the plant upright?', options: ['Flower', 'Stem', 'Root'], correctIndex: 1, explanation: 'The stem holds the plant upright and carries water from roots to leaves.', funFact: 'The stem of a cactus stores water!'),
              EdQuestion(question: 'Which part of a plant becomes a fruit?', options: ['Leaf', 'Root', 'Flower'], correctIndex: 2, explanation: 'After a flower is pollinated it becomes a fruit containing seeds.', funFact: 'A strawberry has its seeds on the outside!'),
              EdQuestion(question: 'Which part of a plant grows into a new plant?', options: ['Flower', 'Seed', 'Leaf'], correctIndex: 1, explanation: 'Seeds grow into new plants when planted in soil with water and sunlight.', funFact: 'The smallest seed in the world is the orchid seed!'),
              EdQuestion(question: 'What colour are most healthy leaves?', options: ['Yellow', 'Green', 'Red'], correctIndex: 1, explanation: 'Most healthy leaves are green because of a substance called chlorophyll.', funFact: 'Chlorophyll is what makes leaves green AND makes food!'),
              EdQuestion(question: 'What do roots absorb from the soil?', options: ['Sunlight', 'Water and minerals', 'Air only'], correctIndex: 1, explanation: 'Roots absorb water and minerals from the soil for the plant.', funFact: 'A single plant can have millions of tiny root hairs!'),
              EdQuestion(question: 'Which part of the plant do we usually smell?', options: ['Root', 'Stem', 'Flower'], correctIndex: 2, explanation: 'Flowers have a sweet smell to attract insects for pollination.', funFact: 'Some flowers only smell at night!'),
              EdQuestion(question: 'What does a plant need to make its food?', options: ['Only water', 'Sunlight, water and air', 'Only soil'], correctIndex: 1, explanation: 'Plants need sunlight, water and air (carbon dioxide) to make food.', funFact: 'Plants release oxygen which we breathe — they are our life support!'),
              EdQuestion(question: 'Which plant part do we eat in a potato?', options: ['Fruit', 'Flower', 'Root/Stem'], correctIndex: 2, explanation: 'A potato is an underground stem called a tuber that we eat.', funFact: 'Potatoes were first grown in South America thousands of years ago!'),
            ],
          ),
          SubTopic(
            topicNumber: 2,
            title: 'Uses of Plants',
            emoji: '🍎',
            questions: [
              EdQuestion(question: 'Which of these do we get from plants?', options: ['Milk', 'Fruits and vegetables', 'Eggs'], correctIndex: 1, explanation: 'Fruits and vegetables come from plants and give us good health.', funFact: 'There are over 20,000 edible plants in the world!'),
              EdQuestion(question: 'From which plant part do we get wood?', options: ['Roots only', 'Trunk/Stem of trees', 'Leaves'], correctIndex: 1, explanation: 'We get wood from the trunk and stem of trees. Wood is used to make furniture.', funFact: 'One tree can provide enough wood to make 170,000 pencils!'),
              EdQuestion(question: 'Which plant gives us cotton for clothes?', options: ['Rose plant', 'Cotton plant', 'Mango tree'], correctIndex: 1, explanation: 'The cotton plant gives us cotton fibre which is used to make clothes.', funFact: 'Your t-shirt might have come from a cotton plant!'),
              EdQuestion(question: 'Plants help us by giving us:', options: ['Dirty air', 'Clean oxygen to breathe', 'Noise'], correctIndex: 1, explanation: 'Plants give us clean oxygen to breathe and absorb the carbon dioxide we breathe out.', funFact: 'One large tree provides a day\'s oxygen for 4 people!'),
              EdQuestion(question: 'Which of these is a medicine from plants?', options: ['Plastic', 'Neem and tulsi', 'Metal'], correctIndex: 1, explanation: 'Neem and tulsi are plants used in traditional medicine to treat illnesses.', funFact: 'More than 50% of medicines come from plants!'),
              EdQuestion(question: 'Which plant gives us rubber?', options: ['Banana tree', 'Rubber tree', 'Coconut tree'], correctIndex: 1, explanation: 'Rubber comes from the rubber tree. It is used to make tyres and erasers.', funFact: 'Your eraser is made from rubber that came from a tree!'),
              EdQuestion(question: 'We should not cut trees because:', options: ['Trees are ugly', 'Trees give us oxygen, food and shelter', 'Trees take up space'], correctIndex: 1, explanation: 'Trees give us oxygen, food, shade, wood and home to animals. We must protect them.', funFact: 'India celebrates Van Mahotsav to plant trees every year!'),
              EdQuestion(question: 'From which plant do we get sugar?', options: ['Mango tree', 'Sugarcane', 'Neem tree'], correctIndex: 1, explanation: 'Sugar is made from sugarcane. India is one of the biggest sugarcane growers.', funFact: 'One sugarcane plant can grow up to 6 metres tall!'),
              EdQuestion(question: 'Which part of a plant do we eat in spinach?', options: ['Root', 'Seed', 'Leaves'], correctIndex: 2, explanation: 'In spinach we eat the leaves which are full of iron and vitamins.', funFact: 'Spinach was Popeye\'s favourite food for strength!'),
              EdQuestion(question: 'Plants give home and food to:', options: ['Only humans', 'Animals, birds and insects too', 'Nobody else'], correctIndex: 1, explanation: 'Plants give food and shelter to animals, birds and insects — the whole ecosystem depends on them.', funFact: 'A single oak tree can be home to over 500 different species!'),
            ],
          ),
        ],
      ),

      // ── Chapter 6: Animals Around Us ──────────────────────────────────
      SchoolChapter(
        chapterNumber: 6,
        title: 'Animals Around Us',
        emoji: '🐾',
        summary: 'Learn about animals, their homes and what they eat',
        subTopics: [
          SubTopic(
            topicNumber: 1,
            title: 'Pet and Wild Animals',
            emoji: '🐕',
            questions: [
              EdQuestion(question: 'Which of these is a pet animal?', options: ['Lion', 'Dog', 'Tiger'], correctIndex: 1, explanation: 'Dogs are pet animals. They live with us at home and are very friendly.', funFact: 'Dogs were the first animals to be tamed by humans thousands of years ago!'),
              EdQuestion(question: 'Which animal lives in a jungle and is wild?', options: ['Cow', 'Cat', 'Tiger'], correctIndex: 2, explanation: 'Tigers are wild animals that live in jungles. They are dangerous.', funFact: 'India is home to more than 3000 tigers!'),
              EdQuestion(question: 'Which of these animals gives us milk?', options: ['Dog', 'Cow', 'Cat'], correctIndex: 1, explanation: 'Cows give us milk which is very nutritious.', funFact: 'A cow can give up to 40 litres of milk every day!'),
              EdQuestion(question: 'Which animal is called "Man\'s best friend"?', options: ['Cat', 'Fish', 'Dog'], correctIndex: 2, explanation: 'Dogs are called man\'s best friend because they are loyal and loving.', funFact: 'Dogs can smell 100,000 times better than humans!'),
              EdQuestion(question: 'Which animal can fly?', options: ['Cat', 'Dog', 'Parrot'], correctIndex: 2, explanation: 'Parrots are birds and they can fly using their wings.', funFact: 'Parrots can learn to speak human words!'),
              EdQuestion(question: 'Which animal lives in water?', options: ['Elephant', 'Fish', 'Horse'], correctIndex: 1, explanation: 'Fish live in water. They breathe through gills.', funFact: 'There are over 30,000 different species of fish!'),
              EdQuestion(question: 'Which animal is the largest land animal?', options: ['Horse', 'Elephant', 'Cow'], correctIndex: 1, explanation: 'The elephant is the largest land animal. It is very strong and intelligent.', funFact: 'Elephants never forget — they have excellent memory!'),
              EdQuestion(question: 'Which animal gives us wool for warm clothes?', options: ['Cat', 'Sheep', 'Dog'], correctIndex: 1, explanation: 'Sheep give us wool which is used to make warm clothes and blankets.', funFact: 'A single sheep can produce up to 10 kg of wool per year!'),
              EdQuestion(question: 'Which animal is known as the "King of the Jungle"?', options: ['Tiger', 'Elephant', 'Lion'], correctIndex: 2, explanation: 'The lion is called the "King of the Jungle" because of its strength and bravery.', funFact: 'Lions live in groups called prides!'),
              EdQuestion(question: 'Which animals lay eggs?', options: ['Cats and dogs', 'Birds and snakes', 'Cows and horses'], correctIndex: 1, explanation: 'Birds and snakes lay eggs. The babies hatch from the eggs.', funFact: 'Ostrich eggs are the largest eggs in the world!'),
            ],
          ),
          SubTopic(
            topicNumber: 2,
            title: 'What Animals Eat',
            emoji: '🌾',
            questions: [
              EdQuestion(question: 'Animals that eat only plants are called:', options: ['Carnivores', 'Omnivores', 'Herbivores'], correctIndex: 2, explanation: 'Herbivores eat only plants, grass and leaves. Cows and deer are herbivores.', funFact: 'Elephants eat up to 150 kg of plants every day!'),
              EdQuestion(question: 'Animals that eat only meat are called:', options: ['Herbivores', 'Carnivores', 'Omnivores'], correctIndex: 1, explanation: 'Carnivores eat only meat. Lions and tigers are carnivores.', funFact: 'Carnivores have sharp teeth for tearing meat!'),
              EdQuestion(question: 'Animals that eat both plants and meat are called:', options: ['Carnivores', 'Herbivores', 'Omnivores'], correctIndex: 2, explanation: 'Omnivores eat both plants and meat. Bears and humans are omnivores.', funFact: 'Humans are omnivores — we can eat both plants and meat!'),
              EdQuestion(question: 'What does a cow eat?', options: ['Meat', 'Grass and hay', 'Fish'], correctIndex: 1, explanation: 'Cows eat grass, hay and leaves. They are herbivores.', funFact: 'A cow chews its food and brings it back up to chew again — called chewing cud!'),
              EdQuestion(question: 'What does a lion eat?', options: ['Grass', 'Fruits', 'Other animals'], correctIndex: 2, explanation: 'Lions eat other animals like deer and zebras. They are carnivores.', funFact: 'Lionesses do most of the hunting in a pride!'),
              EdQuestion(question: 'What does a rabbit eat?', options: ['Meat', 'Carrots and vegetables', 'Fish'], correctIndex: 1, explanation: 'Rabbits eat carrots, vegetables and grass. They are herbivores.', funFact: 'Rabbits\'s teeth never stop growing!'),
              EdQuestion(question: 'What do birds in your garden mostly eat?', options: ['Meat only', 'Seeds, fruits and insects', 'Grass only'], correctIndex: 1, explanation: 'Garden birds eat seeds, fruits, berries and small insects.', funFact: 'Birds help plants by spreading their seeds!'),
              EdQuestion(question: 'What do fish eat?', options: ['Grass', 'Small water creatures and plants', 'Rice'], correctIndex: 1, explanation: 'Fish eat small water creatures, insects and water plants.', funFact: 'Whale sharks eat tiny creatures called plankton!'),
              EdQuestion(question: 'What do butterflies eat?', options: ['Leaves', 'Nectar from flowers', 'Other insects'], correctIndex: 1, explanation: 'Butterflies drink nectar from flowers using their long tube-like mouth.', funFact: 'Butterflies taste with their feet!'),
              EdQuestion(question: 'Which animal eats both fish and berries?', options: ['Cow', 'Bear', 'Deer'], correctIndex: 1, explanation: 'Bears eat both fish and berries. They are omnivores.', funFact: 'Brown bears can eat 20,000 calories a day before winter!'),
            ],
          ),
        ],
      ),

    ], // end EVS chapters
  );

  // ══════════════════════════════════════════════════════════════════════════
  // NCERT CLASS 1 — MATHS "Magic of Mathematics"
  // Chapters: 1.Shapes  2.Numbers 1-9  3.Addition  4.Subtraction
  //           5.Numbers 10-20  6.Time  7.Measurement  8.Data Handling
  // ══════════════════════════════════════════════════════════════════════════

  static const SchoolSubject _maths = SchoolSubject(
    id: 'class1_maths',
    name: 'Maths',
    emoji: '🔢',
    color: Color(0xFF3498DB),
    description: 'Magic of Mathematics — numbers, shapes and patterns',
    chapters: [

      // ── Chapter 1: Shapes and Space ────────────────────────────────────
      SchoolChapter(
        chapterNumber: 1,
        title: 'Shapes and Space',
        emoji: '🔷',
        summary: 'Recognise shapes and understand inside, outside, near, far',
        subTopics: [
          SubTopic(
            topicNumber: 1,
            title: 'Basic Shapes',
            emoji: '⭕',
            questions: [
              EdQuestion(question: 'How many sides does a square have?', options: ['3', '4', '5'], correctIndex: 1, explanation: 'A square has 4 equal sides and 4 corners.', funFact: 'All four sides of a square are exactly the same length!'),
              EdQuestion(question: 'How many sides does a triangle have?', options: ['2', '4', '3'], correctIndex: 2, explanation: 'A triangle has 3 sides and 3 corners.', funFact: 'The pyramids of Egypt are triangular in shape!'),
              EdQuestion(question: 'Which shape has no corners or sides?', options: ['Square', 'Triangle', 'Circle'], correctIndex: 2, explanation: 'A circle is a round shape with no corners or straight sides.', funFact: 'Wheels are circular so they can roll smoothly!'),
              EdQuestion(question: 'How many sides does a rectangle have?', options: ['3', '4', '5'], correctIndex: 1, explanation: 'A rectangle has 4 sides — 2 long sides and 2 short sides.', funFact: 'Most doors and windows are shaped like rectangles!'),
              EdQuestion(question: 'Which shape looks like a ball?', options: ['Cube', 'Sphere', 'Cone'], correctIndex: 1, explanation: 'A sphere is a solid round shape like a ball.', funFact: 'The Earth is shaped like a sphere!'),
              EdQuestion(question: 'Which shape looks like a box?', options: ['Cone', 'Sphere', 'Cube'], correctIndex: 2, explanation: 'A cube has 6 square faces, like a dice or a box.', funFact: 'A Rubik\'s cube is a famous cube-shaped puzzle!'),
              EdQuestion(question: 'Which shape looks like an ice cream cone?', options: ['Cube', 'Cone', 'Cylinder'], correctIndex: 1, explanation: 'A cone has a round base and comes to a point at the top, like an ice cream cone.', funFact: 'Traffic cones use this shape because they are easy to see!'),
              EdQuestion(question: 'Which shape looks like a can of juice?', options: ['Cone', 'Sphere', 'Cylinder'], correctIndex: 2, explanation: 'A cylinder has two circular ends and a curved side, like a can or a drum.', funFact: 'Most food cans are cylinders!'),
              EdQuestion(question: 'A window is usually which shape?', options: ['Triangle', 'Rectangle', 'Circle'], correctIndex: 1, explanation: 'Most windows are rectangular in shape.', funFact: 'Some church windows are circular and called "rose windows"!'),
              EdQuestion(question: 'Which shape does a pizza look like?', options: ['Square', 'Triangle', 'Circle'], correctIndex: 2, explanation: 'A whole pizza is circular in shape before it is cut into triangular slices.', funFact: 'When pizza is cut into slices, those slices are triangles!'),
            ],
          ),
          SubTopic(
            topicNumber: 2,
            title: 'Position Words',
            emoji: '↔️',
            questions: [
              EdQuestion(question: 'If a ball is in the box, where is it?', options: ['Outside', 'Inside', 'On top'], correctIndex: 1, explanation: 'If a ball is in the box, it is inside the box.', funFact: 'We use position words every day to describe where things are!'),
              EdQuestion(question: 'What is the opposite of "near"?', options: ['Close', 'Far', 'Here'], correctIndex: 1, explanation: '"Far" is the opposite of "near". Near means close by, far means a long distance away.', funFact: 'The Moon is very far from Earth — about 384,000 km!'),
              EdQuestion(question: 'If a cat is on the chair, where is the cat?', options: ['Under the chair', 'On top of the chair', 'Next to the chair'], correctIndex: 1, explanation: 'If a cat is on the chair, it is sitting on top of the chair.', funFact: 'Cats love to sit in high places so they can watch everything!'),
              EdQuestion(question: 'What is the opposite of "inside"?', options: ['Below', 'Outside', 'Above'], correctIndex: 1, explanation: '"Outside" is the opposite of "inside".', funFact: 'We go outside to play and come inside to eat and sleep!'),
              EdQuestion(question: 'If a bird is above the tree, where is the bird?', options: ['Below the tree', 'Inside the tree', 'Higher than the tree'], correctIndex: 2, explanation: 'Above means higher than something. The bird is flying higher than the tree.', funFact: 'Eagles can fly up to 3000 metres above the ground!'),
              EdQuestion(question: 'What is the opposite of "above"?', options: ['Side', 'Below', 'Near'], correctIndex: 1, explanation: '"Below" is the opposite of "above". Below means lower than something.', funFact: 'We sleep below the blanket to stay warm!'),
              EdQuestion(question: 'Where is a fish — in water or on land?', options: ['On land', 'In water', 'In the air'], correctIndex: 1, explanation: 'Fish live in water. They cannot survive on land.', funFact: 'Some fish live in very deep water where there is no light at all!'),
              EdQuestion(question: 'If a book is between two pencils, where is the book?', options: ['On top', 'In the middle of the two pencils', 'Below the pencils'], correctIndex: 1, explanation: '"Between" means in the middle of two things. The book is in the middle.', funFact: 'We use "between" when something is in the middle of two other things!'),
              EdQuestion(question: 'Your school is near your home or far?', options: ['Always far', 'It depends — near or far', 'Always near'], correctIndex: 1, explanation: 'The distance to school depends on where you live — it can be near or far.', funFact: 'In some countries, children walk for hours to reach school!'),
              EdQuestion(question: 'If your eraser is under the desk, where is it?', options: ['On the desk', 'Below the desk', 'Inside the desk'], correctIndex: 1, explanation: '"Under" means below something. The eraser is below/under the desk.', funFact: 'Always put your things in the right place so you can find them!'),
            ],
          ),
        ],
      ),

      // ── Chapter 2: Numbers 1 to 9 ──────────────────────────────────────
      SchoolChapter(
        chapterNumber: 2,
        title: 'Numbers 1 to 9',
        emoji: '🔢',
        summary: 'Count, read and write numbers from 1 to 9',
        subTopics: [
          SubTopic(
            topicNumber: 1,
            title: 'Counting 1 to 5',
            emoji: '🖐️',
            questions: [
              EdQuestion(question: 'How many fingers are on one hand?', options: ['4', '5', '6'], correctIndex: 1, explanation: 'There are 5 fingers on one hand.', funFact: 'We can count to 5 using just one hand!'),
              EdQuestion(question: 'Count the stars: ⭐⭐⭐ How many?', options: ['2', '4', '3'], correctIndex: 2, explanation: 'There are 3 stars. We count: 1, 2, 3.', funFact: 'Counting is the first step in learning maths!'),
              EdQuestion(question: 'Which number comes after 2?', options: ['1', '4', '3'], correctIndex: 2, explanation: 'The number after 2 is 3. We count: 1, 2, 3...', funFact: 'Numbers go on forever — there is no last number!'),
              EdQuestion(question: 'Which number comes before 5?', options: ['6', '4', '3'], correctIndex: 1, explanation: 'The number before 5 is 4. We count: ...3, 4, 5.', funFact: 'We use "before" and "after" for numbers just like for time!'),
              EdQuestion(question: 'Count the apples: 🍎🍎🍎🍎 How many?', options: ['3', '5', '4'], correctIndex: 2, explanation: 'There are 4 apples. We count: 1, 2, 3, 4.', funFact: 'The number 4 looks like a flag on a stick!'),
              EdQuestion(question: 'Which is the smallest number from 1 to 5?', options: ['5', '3', '1'], correctIndex: 2, explanation: '1 is the smallest number from 1 to 5.', funFact: 'Number 1 is a very special number — it starts all counting!'),
              EdQuestion(question: 'How many wheels does a tricycle have?', options: ['2', '4', '3'], correctIndex: 2, explanation: 'A tricycle has 3 wheels. "Tri" means three!', funFact: 'Tri means 3 — triangle has 3 sides, tricycle has 3 wheels!'),
              EdQuestion(question: 'Count: 🌟🌟 How many stars?', options: ['1', '3', '2'], correctIndex: 2, explanation: 'There are 2 stars. We count: 1, 2.', funFact: 'The number 2 is the only even prime number!'),
              EdQuestion(question: 'What comes after 4?', options: ['3', '6', '5'], correctIndex: 2, explanation: 'The number after 4 is 5. We count: 1, 2, 3, 4, 5.', funFact: 'We have 5 fingers on each hand — perfect for counting to 5!'),
              EdQuestion(question: 'How many legs does a dog have?', options: ['2', '6', '4'], correctIndex: 2, explanation: 'A dog has 4 legs. Most animals like cats, cows, and horses also have 4 legs.', funFact: 'Insects have 6 legs and spiders have 8 legs!'),
            ],
          ),
          SubTopic(
            topicNumber: 2,
            title: 'Counting 6 to 9',
            emoji: '9️⃣',
            questions: [
              EdQuestion(question: 'Which number comes after 6?', options: ['5', '8', '7'], correctIndex: 2, explanation: 'The number after 6 is 7. We count: ...5, 6, 7...', funFact: 'Lucky number 7 is many people\'s favourite number!'),
              EdQuestion(question: 'Count: 🦋🦋🦋🦋🦋🦋 How many butterflies?', options: ['5', '7', '6'], correctIndex: 2, explanation: 'There are 6 butterflies. Count carefully: 1, 2, 3, 4, 5, 6.', funFact: 'Butterflies taste things with their feet!'),
              EdQuestion(question: 'Which number comes before 9?', options: ['7', '6', '8'], correctIndex: 2, explanation: 'The number before 9 is 8. We count: ...7, 8, 9.', funFact: 'An octopus has 8 arms — oct means 8!'),
              EdQuestion(question: 'How many colours are in a rainbow?', options: ['6', '8', '7'], correctIndex: 2, explanation: 'A rainbow has 7 colours: red, orange, yellow, green, blue, indigo and violet.', funFact: 'You can remember rainbow colours as VIBGYOR!'),
              EdQuestion(question: 'Which is the biggest number: 6, 7, 8 or 9?', options: ['6', '7', '9'], correctIndex: 2, explanation: '9 is the biggest single digit number.', funFact: '9 is the last single-digit number before we get to 10!'),
              EdQuestion(question: 'A spider has how many legs?', options: ['6', '8', '10'], correctIndex: 1, explanation: 'A spider has 8 legs. Spiders are not insects — they are arachnids.', funFact: 'Spiders use their 8 legs to spin webs and catch food!'),
              EdQuestion(question: 'Count: 🌙🌙🌙🌙🌙🌙🌙 How many moons?', options: ['6', '8', '7'], correctIndex: 2, explanation: 'There are 7 moons. Count: 1, 2, 3, 4, 5, 6, 7.', funFact: 'Our planet Earth has only one Moon!'),
              EdQuestion(question: 'Which number comes between 7 and 9?', options: ['6', '8', '10'], correctIndex: 1, explanation: '8 comes between 7 and 9. We count: 7, 8, 9.', funFact: 'When 8 is turned on its side it becomes the infinity symbol ∞!'),
              EdQuestion(question: 'How many days are in a week?', options: ['5', '6', '7'], correctIndex: 2, explanation: 'There are 7 days in a week: Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday.', funFact: 'We go to school for 5 days and have 2 days off each week!'),
              EdQuestion(question: 'What comes after 8?', options: ['7', '6', '9'], correctIndex: 2, explanation: '9 comes after 8. We count: ...7, 8, 9.', funFact: 'After 9 comes 10 — our first two-digit number!'),
            ],
          ),
          SubTopic(
            topicNumber: 3,
            title: 'Comparing Numbers',
            emoji: '⚖️',
            questions: [
              EdQuestion(question: 'Which is more — 3 or 5?', options: ['3', '5', 'Both same'], correctIndex: 1, explanation: '5 is more than 3. We can check by counting: 3 comes before 5.', funFact: 'We use > (greater than) and < (less than) signs to compare numbers!'),
              EdQuestion(question: 'Which is less — 7 or 4?', options: ['7', '4', 'Both same'], correctIndex: 1, explanation: '4 is less than 7. 4 comes before 7 when we count.', funFact: 'Less means smaller in amount!'),
              EdQuestion(question: 'Are 5 and 5 equal?', options: ['No', 'Yes', 'Not sure'], correctIndex: 1, explanation: 'Yes! 5 and 5 are equal — they are the same number.', funFact: 'The = sign means "equal to" or "the same as"!'),
              EdQuestion(question: 'Which group has more: 🐕🐕🐕 or 🐈🐈?', options: ['Cats have more', 'Dogs have more', 'Both same'], correctIndex: 1, explanation: '3 dogs is more than 2 cats. 3 > 2.', funFact: 'We can always count to find out which group is more!'),
              EdQuestion(question: '6 is greater than 4. True or False?', options: ['False', 'True', 'Same'], correctIndex: 1, explanation: 'True! 6 is greater than 4 because 6 comes after 4 when counting.', funFact: 'Greater means bigger or more in number!'),
              EdQuestion(question: 'Which number is smallest: 2, 8, 5?', options: ['8', '5', '2'], correctIndex: 2, explanation: '2 is the smallest because it comes first when we count: 2, 5, 8.', funFact: 'We can put numbers in order from smallest to biggest!'),
              EdQuestion(question: 'Which number is biggest: 3, 9, 6?', options: ['3', '6', '9'], correctIndex: 2, explanation: '9 is the biggest because it comes last when we count: 3, 6, 9.', funFact: '9 is the biggest single-digit number we can write with one digit!'),
              EdQuestion(question: '1 apple and 8 apples — which is more?', options: ['1 apple', '8 apples', 'Same'], correctIndex: 1, explanation: '8 apples is much more than 1 apple. 8 > 1.', funFact: 'We compare quantities every day — like sharing food equally!'),
              EdQuestion(question: 'Put in order from small to big: 4, 1, 7', options: ['7, 4, 1', '1, 7, 4', '1, 4, 7'], correctIndex: 2, explanation: 'From smallest to biggest: 1, 4, 7. We count to find the right order.', funFact: 'Putting numbers in order is called "ordering" or "arranging"!'),
              EdQuestion(question: 'How many more is 9 than 6?', options: ['4', '2', '3'], correctIndex: 2, explanation: '9 is 3 more than 6. We count from 6 to 9: 6...7, 8, 9 — that is 3 more.', funFact: 'Finding "how many more" helps us with subtraction!'),
            ],
          ),
        ],
      ),

      // ── Chapter 3: Addition ────────────────────────────────────────────
      SchoolChapter(
        chapterNumber: 3,
        title: 'Addition',
        emoji: '➕',
        summary: 'Learn to add numbers together',
        subTopics: [
          SubTopic(
            topicNumber: 1,
            title: 'Adding Small Numbers',
            emoji: '🧮',
            questions: [
              EdQuestion(question: '1 + 1 = ?', options: ['1', '2', '3'], correctIndex: 1, explanation: '1 + 1 = 2. If you have 1 apple and get 1 more, you have 2 apples!', funFact: 'Addition is putting things together!'),
              EdQuestion(question: '2 + 3 = ?', options: ['4', '5', '6'], correctIndex: 1, explanation: '2 + 3 = 5. Count on from 2: 3, 4, 5.', funFact: 'The + sign is called the "plus" sign!'),
              EdQuestion(question: '4 + 2 = ?', options: ['5', '7', '6'], correctIndex: 2, explanation: '4 + 2 = 6. Count on from 4: 5, 6.', funFact: 'We can add numbers in any order and get the same answer: 4+2 = 2+4 = 6!'),
              EdQuestion(question: '3 + 3 = ?', options: ['5', '6', '7'], correctIndex: 1, explanation: '3 + 3 = 6. Count on from 3: 4, 5, 6.', funFact: 'Adding the same number twice is called "doubling"!'),
              EdQuestion(question: 'There are 2 birds on a tree. 3 more come. How many birds now?', options: ['4', '6', '5'], correctIndex: 2, explanation: '2 + 3 = 5. Count on: 2, then 3 more makes 3, 4, 5.', funFact: 'We use addition in real life all the time — like counting birds!'),
              EdQuestion(question: '1 + 4 = ?', options: ['4', '5', '6'], correctIndex: 1, explanation: '1 + 4 = 5. Start at 1, count 4 more: 2, 3, 4, 5.', funFact: 'Counting on is the easiest way to add!'),
              EdQuestion(question: '5 + 0 = ?', options: ['0', '6', '5'], correctIndex: 2, explanation: '5 + 0 = 5. Adding zero to a number does not change it.', funFact: 'Zero is a very special number — adding it changes nothing!'),
              EdQuestion(question: '2 + 2 = ?', options: ['3', '4', '5'], correctIndex: 1, explanation: '2 + 2 = 4. Count: 2, then 2 more: 3, 4.', funFact: '2 + 2 = 4 is one of the most well-known maths facts!'),
              EdQuestion(question: 'Ravi has 3 pencils. He gets 1 more. How many pencils?', options: ['3', '5', '4'], correctIndex: 2, explanation: '3 + 1 = 4 pencils. Count on from 3: 4.', funFact: 'Addition helps us count our belongings!'),
              EdQuestion(question: '0 + 6 = ?', options: ['0', '7', '6'], correctIndex: 2, explanation: '0 + 6 = 6. When we add 0 to 6, we get 6. Zero adds nothing.', funFact: 'Zero was invented by an Indian mathematician — Aryabhata!'),
            ],
          ),
          SubTopic(
            topicNumber: 2,
            title: 'Adding to Make 10',
            emoji: '🔟',
            questions: [
              EdQuestion(question: '5 + 5 = ?', options: ['9', '10', '11'], correctIndex: 1, explanation: '5 + 5 = 10. This is a very important maths fact to remember!', funFact: 'We have 10 fingers — perfect for counting to 10!'),
              EdQuestion(question: '7 + 3 = ?', options: ['9', '11', '10'], correctIndex: 2, explanation: '7 + 3 = 10. Count on from 7: 8, 9, 10.', funFact: 'Pairs that add up to 10 are called "number bonds of 10"!'),
              EdQuestion(question: '6 + 4 = ?', options: ['9', '10', '11'], correctIndex: 1, explanation: '6 + 4 = 10. Count on from 6: 7, 8, 9, 10.', funFact: '6 and 4 are number bonds of 10!'),
              EdQuestion(question: '8 + 2 = ?', options: ['9', '10', '11'], correctIndex: 1, explanation: '8 + 2 = 10. Count on from 8: 9, 10.', funFact: '8 and 2 are a number bond pair for 10!'),
              EdQuestion(question: '9 + 1 = ?', options: ['8', '10', '11'], correctIndex: 1, explanation: '9 + 1 = 10. Count on from 9: 10.', funFact: '9 and 1 make 10 — just one more than 9!'),
              EdQuestion(question: '4 + 5 = ?', options: ['8', '10', '9'], correctIndex: 2, explanation: '4 + 5 = 9. Count on from 4: 5, 6, 7, 8, 9.', funFact: 'Counting on fingers helps when we first learn addition!'),
              EdQuestion(question: '3 + 6 = ?', options: ['8', '9', '10'], correctIndex: 1, explanation: '3 + 6 = 9. Count on from 3: 4, 5, 6, 7, 8, 9.', funFact: '3 + 6 = 9 and also 6 + 3 = 9. The order doesn\'t matter!'),
              EdQuestion(question: 'Priya has 5 flowers. She picks 4 more. How many flowers?', options: ['8', '10', '9'], correctIndex: 2, explanation: '5 + 4 = 9 flowers total.', funFact: 'We use addition to combine groups of things!'),
              EdQuestion(question: '2 + 7 = ?', options: ['8', '9', '10'], correctIndex: 1, explanation: '2 + 7 = 9. Count on from 2: 3, 4, 5, 6, 7, 8, 9.', funFact: 'Starting from the bigger number makes counting easier: start at 7, add 2 more!'),
              EdQuestion(question: 'What number added to 3 makes 10?', options: ['6', '8', '7'], correctIndex: 2, explanation: '3 + 7 = 10. So we need to add 7 to 3 to get 10.', funFact: '3 and 7 are number bonds of 10!'),
            ],
          ),
        ],
      ),

      // ── Chapter 4: Subtraction ─────────────────────────────────────────
      SchoolChapter(
        chapterNumber: 4,
        title: 'Subtraction',
        emoji: '➖',
        summary: 'Learn to take away and find what is left',
        subTopics: [
          SubTopic(
            topicNumber: 1,
            title: 'Taking Away',
            emoji: '🎈',
            questions: [
              EdQuestion(question: '5 - 2 = ?', options: ['2', '3', '4'], correctIndex: 1, explanation: '5 - 2 = 3. If you have 5 sweets and eat 2, you have 3 left.', funFact: 'Subtraction means taking away or finding the difference!'),
              EdQuestion(question: '4 - 1 = ?', options: ['2', '4', '3'], correctIndex: 2, explanation: '4 - 1 = 3. Remove 1 from 4 and 3 are left.', funFact: 'The - sign is called the "minus" sign!'),
              EdQuestion(question: '6 - 3 = ?', options: ['2', '3', '4'], correctIndex: 1, explanation: '6 - 3 = 3. Count back from 6 three times: 5, 4, 3.', funFact: 'Subtraction is the opposite of addition!'),
              EdQuestion(question: 'There are 5 balloons. 2 fly away. How many are left?', options: ['2', '4', '3'], correctIndex: 2, explanation: '5 - 2 = 3 balloons are left.', funFact: 'We use subtraction to find out how many are left!'),
              EdQuestion(question: '7 - 4 = ?', options: ['2', '3', '4'], correctIndex: 1, explanation: '7 - 4 = 3. Count back from 7 four times: 6, 5, 4, 3.', funFact: 'Counting back helps us subtract!'),
              EdQuestion(question: '3 - 3 = ?', options: ['1', '0', '3'], correctIndex: 1, explanation: '3 - 3 = 0. When we take all away, nothing is left — zero!', funFact: 'When we take away the same amount, we get zero!'),
              EdQuestion(question: '8 - 5 = ?', options: ['2', '4', '3'], correctIndex: 2, explanation: '8 - 5 = 3. Count back 5 from 8: 7, 6, 5, 4, 3.', funFact: 'We can check subtraction by adding: 3 + 5 = 8!'),
              EdQuestion(question: 'Aman has 6 mangoes. He gives 2 to his friend. How many left?', options: ['3', '5', '4'], correctIndex: 2, explanation: '6 - 2 = 4 mangoes are left.', funFact: 'Sharing is caring — and maths helps us share fairly!'),
              EdQuestion(question: '9 - 6 = ?', options: ['2', '4', '3'], correctIndex: 2, explanation: '9 - 6 = 3. Count back 6 from 9: 8, 7, 6, 5, 4, 3.', funFact: 'We can also subtract using our fingers!'),
              EdQuestion(question: '5 - 0 = ?', options: ['0', '5', '4'], correctIndex: 1, explanation: '5 - 0 = 5. Taking away zero means nothing changes.', funFact: 'Zero is magic — subtracting it keeps the number the same!'),
            ],
          ),
          SubTopic(
            topicNumber: 2,
            title: 'Subtraction Stories',
            emoji: '📖',
            questions: [
              EdQuestion(question: 'Meena had 7 biscuits. She ate 3. How many are left?', options: ['3', '5', '4'], correctIndex: 2, explanation: '7 - 3 = 4 biscuits are left.', funFact: 'Story problems help us understand when to use subtraction!'),
              EdQuestion(question: 'There were 9 birds on a wire. 5 flew away. How many remain?', options: ['3', '5', '4'], correctIndex: 2, explanation: '9 - 5 = 4 birds remain on the wire.', funFact: 'Birds that migrate fly away and come back in different seasons!'),
              EdQuestion(question: 'A basket had 8 oranges. 3 were eaten. How many oranges left?', options: ['4', '6', '5'], correctIndex: 2, explanation: '8 - 3 = 5 oranges are left in the basket.', funFact: 'Oranges are full of Vitamin C which keeps us healthy!'),
              EdQuestion(question: 'Rohit had 6 crayons. He lost 2. How many does he have?', options: ['3', '5', '4'], correctIndex: 2, explanation: '6 - 2 = 4 crayons. He has 4 crayons left.', funFact: 'Always keep your crayons safe so you don\'t lose them!'),
              EdQuestion(question: 'There are 5 fish in a bowl. 1 is taken out. How many are left?', options: ['3', '5', '4'], correctIndex: 2, explanation: '5 - 1 = 4 fish are left in the bowl.', funFact: 'Goldfish need clean water and food to stay healthy!'),
              EdQuestion(question: '10 - 4 = ?', options: ['5', '7', '6'], correctIndex: 2, explanation: '10 - 4 = 6. Count back 4 from 10: 9, 8, 7, 6.', funFact: 'We can check: 6 + 4 = 10. Correct!'),
              EdQuestion(question: 'Sita picked 9 flowers. She gave 4 to teacher. How many left?', options: ['4', '6', '5'], correctIndex: 2, explanation: '9 - 4 = 5 flowers are left with Sita.', funFact: 'Giving flowers is a way to show respect and love!'),
              EdQuestion(question: '8 - 8 = ?', options: ['1', '0', '8'], correctIndex: 1, explanation: '8 - 8 = 0. When we take all of them away, nothing is left.', funFact: 'Any number minus itself always equals zero!'),
              EdQuestion(question: 'A box had 7 chocolates. 5 were eaten. How many left?', options: ['1', '3', '2'], correctIndex: 2, explanation: '7 - 5 = 2 chocolates are left in the box.', funFact: 'Chocolate comes from the cacao tree!'),
              EdQuestion(question: '10 - 7 = ?', options: ['2', '4', '3'], correctIndex: 2, explanation: '10 - 7 = 3. Count back 7 from 10: 9, 8, 7, 6, 5, 4, 3.', funFact: 'Check it: 3 + 7 = 10. That confirms our answer!'),
            ],
          ),
        ],
      ),

    ], // end Maths chapters
  );

  // ══════════════════════════════════════════════════════════════════════════
  // CLASS 1 — Complete class object
  // ══════════════════════════════════════════════════════════════════════════
  static SchoolClass get class1 => const SchoolClass(
    classNumber: 1,
    label: 'Class 1',
    emoji: '1️⃣',
    subjects: [_evs, _maths],
  );

  // All classes list (add more as we build)
  static List<SchoolClass> get allClasses => [
    class1,
    // class2, class3 ... coming soon
  ];

  // Timer per class (older class = less time)
  static int getTimer(int classNumber) {
    switch (classNumber) {
      case 1: return 45;
      case 2: return 40;
      case 3: return 35;
      default: return 30;
    }
  }
}
