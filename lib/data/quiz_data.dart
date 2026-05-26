import '../models/quiz_model.dart';

class QuizData {

  // ── GENERAL KNOWLEDGE (25 questions) ─────────────────────────────────────
  static const List<Question> _general = [
    Question(question: 'What is the capital of France?', options: ['Berlin','Madrid','Paris','Rome'], correctIndex: 2, explanation: 'Paris has been the capital of France since the 10th century.'),
    Question(question: 'Which planet is known as the Red Planet?', options: ['Venus','Mars','Jupiter','Saturn'], correctIndex: 1, explanation: 'Mars appears red due to iron oxide (rust) on its surface.'),
    Question(question: 'Who painted the Mona Lisa?', options: ['Van Gogh','Picasso','Michelangelo','Leonardo da Vinci'], correctIndex: 3, explanation: 'Leonardo da Vinci painted the Mona Lisa between 1503–1519.'),
    Question(question: 'What is the largest ocean on Earth?', options: ['Atlantic','Indian','Pacific','Arctic'], correctIndex: 2, explanation: 'The Pacific Ocean covers more than 165 million square kilometres.'),
    Question(question: 'How many continents are there on Earth?', options: ['5','6','7','8'], correctIndex: 2, explanation: 'Earth has 7 continents: Africa, Antarctica, Asia, Australia, Europe, North America, and South America.'),
    Question(question: 'What is the chemical symbol for water?', options: ['WA','H2O','HO2','W2O'], correctIndex: 1, explanation: 'Water is composed of two hydrogen atoms and one oxygen atom (H₂O).'),
    Question(question: 'Which country is home to the kangaroo?', options: ['South Africa','India','Brazil','Australia'], correctIndex: 3, explanation: 'Kangaroos are native to Australia and are one of its national symbols.'),
    Question(question: 'What is the speed of light?', options: ['300,000 km/s','150,000 km/s','450,000 km/s','100,000 km/s'], correctIndex: 0, explanation: 'Light travels at approximately 299,792 km per second in a vacuum.'),
    Question(question: 'Who wrote "Romeo and Juliet"?', options: ['Charles Dickens','Mark Twain','William Shakespeare','Jane Austen'], correctIndex: 2, explanation: 'Romeo and Juliet was written by William Shakespeare around 1594–1596.'),
    Question(question: 'What is the largest mammal in the world?', options: ['Elephant','Blue Whale','Giraffe','Polar Bear'], correctIndex: 1, explanation: 'The blue whale is the largest animal ever known to have existed, up to 30 metres long.'),
    Question(question: 'Which element has the symbol "Au"?', options: ['Silver','Copper','Gold','Aluminium'], correctIndex: 2, explanation: 'Au comes from the Latin word "aurum" meaning gold.'),
    Question(question: 'How many sides does a hexagon have?', options: ['5','6','7','8'], correctIndex: 1, explanation: 'A hexagon has exactly six sides and six angles.'),
    Question(question: 'Which gas do plants absorb from the atmosphere?', options: ['Oxygen','Nitrogen','Carbon Dioxide','Hydrogen'], correctIndex: 2, explanation: 'Plants absorb CO₂ during photosynthesis and release oxygen.'),
    Question(question: 'What is the tallest mountain in the world?', options: ['K2','Kangchenjunga','Mount Everest','Lhotse'], correctIndex: 2, explanation: 'Mount Everest stands at 8,849 metres above sea level.'),
    Question(question: 'In which year did World War II end?', options: ['1943','1944','1945','1946'], correctIndex: 2, explanation: 'World War II ended in 1945 with Germany surrendering in May and Japan in September.'),
    Question(question: 'Which planet is closest to the Sun?', options: ['Venus','Earth','Mercury','Mars'], correctIndex: 2, explanation: 'Mercury is the closest planet to the Sun, orbiting at about 57.9 million km away.'),
    Question(question: 'What is the currency of Japan?', options: ['Yuan','Won','Rupee','Yen'], correctIndex: 3, explanation: 'The Japanese Yen (¥) has been Japan\'s currency since 1871.'),
    Question(question: 'How many bones are in the adult human body?', options: ['196','206','216','226'], correctIndex: 1, explanation: 'Adults have 206 bones; babies are born with around 270 that fuse over time.'),
    Question(question: 'Which country invented pizza?', options: ['France','Greece','Italy','Spain'], correctIndex: 2, explanation: 'Pizza originated in Naples, Italy, in the 18th or early 19th century.'),
    Question(question: 'What is the hardest natural substance on Earth?', options: ['Ruby','Iron','Diamond','Quartz'], correctIndex: 2, explanation: 'Diamond scores 10 on the Mohs hardness scale, the maximum.'),
    Question(question: 'How many strings does a standard guitar have?', options: ['4','5','6','7'], correctIndex: 2, explanation: 'A standard acoustic or electric guitar has 6 strings.'),
    Question(question: 'Which ocean is the smallest?', options: ['Southern','Indian','Atlantic','Arctic'], correctIndex: 3, explanation: 'The Arctic Ocean is the smallest and shallowest of the five oceans.'),
    Question(question: 'What language has the most native speakers?', options: ['English','Spanish','Mandarin Chinese','Hindi'], correctIndex: 2, explanation: 'Mandarin Chinese has the most native speakers with over 900 million.'),
    Question(question: 'Which planet has the most moons?', options: ['Jupiter','Saturn','Uranus','Neptune'], correctIndex: 1, explanation: 'Saturn has 146 confirmed moons as of 2023, more than any other planet.'),
    Question(question: 'What is the smallest country in the world?', options: ['Monaco','San Marino','Vatican City','Liechtenstein'], correctIndex: 2, explanation: 'Vatican City covers just 0.44 km², making it the world\'s smallest country.'),
  ];

  // ── SCIENCE (25 questions) ────────────────────────────────────────────────
  static const List<Question> _science = [
    Question(question: 'What is the powerhouse of the cell?', options: ['Nucleus','Ribosome','Mitochondria','Golgi apparatus'], correctIndex: 2, explanation: 'Mitochondria produce ATP, the energy currency of the cell, through cellular respiration.'),
    Question(question: 'What is the atomic number of carbon?', options: ['4','6','8','12'], correctIndex: 1, explanation: 'Carbon has 6 protons in its nucleus, giving it atomic number 6.'),
    Question(question: 'Which scientist developed the theory of general relativity?', options: ['Newton','Tesla','Einstein','Bohr'], correctIndex: 2, explanation: 'Albert Einstein published his general theory of relativity in 1915.'),
    Question(question: 'What is the most abundant gas in Earth\'s atmosphere?', options: ['Oxygen','Argon','Carbon Dioxide','Nitrogen'], correctIndex: 3, explanation: 'Nitrogen makes up about 78% of Earth\'s atmosphere.'),
    Question(question: 'What force keeps planets in orbit around the Sun?', options: ['Magnetism','Gravity','Friction','Electrostatic force'], correctIndex: 1, explanation: 'Gravity is the attractive force between masses that keeps planets in their orbits.'),
    Question(question: 'What is the pH of pure water?', options: ['5','6','7','8'], correctIndex: 2, explanation: 'Pure water has a neutral pH of 7 at 25°C.'),
    Question(question: 'Which organ produces insulin?', options: ['Liver','Kidney','Pancreas','Stomach'], correctIndex: 2, explanation: 'The pancreas produces insulin, which regulates blood glucose levels.'),
    Question(question: 'How many chambers does the human heart have?', options: ['2','3','4','5'], correctIndex: 2, explanation: 'The human heart has four chambers: two atria and two ventricles.'),
    Question(question: 'What is the chemical formula for table salt?', options: ['NaCl','KCl','CaCl2','MgCl2'], correctIndex: 0, explanation: 'Table salt is sodium chloride, composed of one sodium and one chlorine atom.'),
    Question(question: 'What type of bond holds water molecules together?', options: ['Ionic','Covalent','Hydrogen','Metallic'], correctIndex: 2, explanation: 'Hydrogen bonds form between water molecules due to polarity.'),
    Question(question: 'Which planet has the Great Red Spot?', options: ['Saturn','Uranus','Neptune','Jupiter'], correctIndex: 3, explanation: 'Jupiter\'s Great Red Spot is a storm larger than Earth that has lasted over 350 years.'),
    Question(question: 'What is the unit of electrical resistance?', options: ['Volt','Ampere','Ohm','Watt'], correctIndex: 2, explanation: 'The ohm (Ω) is the SI unit of electrical resistance, named after Georg Ohm.'),
    Question(question: 'Which vitamin is produced when skin is exposed to sunlight?', options: ['Vitamin A','Vitamin B12','Vitamin C','Vitamin D'], correctIndex: 3, explanation: 'Sunlight triggers vitamin D synthesis in the skin via UV-B radiation.'),
    Question(question: 'What is the center of an atom called?', options: ['Proton','Electron','Nucleus','Neutron'], correctIndex: 2, explanation: 'The nucleus is the dense core of an atom containing protons and neutrons.'),
    Question(question: 'Which gas is released by photosynthesis?', options: ['Carbon Dioxide','Hydrogen','Nitrogen','Oxygen'], correctIndex: 3, explanation: 'Photosynthesis splits water molecules and releases oxygen as a by-product.'),
    Question(question: 'What is Newton\'s first law also called?', options: ['Law of Acceleration','Law of Inertia','Law of Action-Reaction','Law of Gravity'], correctIndex: 1, explanation: 'Newton\'s first law states an object at rest stays at rest unless acted on by a force — the law of inertia.'),
    Question(question: 'What is the boiling point of water at sea level?', options: ['90°C','95°C','100°C','105°C'], correctIndex: 2, explanation: 'Water boils at 100°C (212°F) at standard atmospheric pressure.'),
    Question(question: 'What particle has a negative charge?', options: ['Proton','Neutron','Electron','Positron'], correctIndex: 2, explanation: 'Electrons carry a negative electric charge and orbit the atom\'s nucleus.'),
    Question(question: 'Which blood type is the universal donor?', options: ['A+','B+','AB+','O-'], correctIndex: 3, explanation: 'O- blood can be given to anyone because it lacks A, B, and Rh antigens.'),
    Question(question: 'What is the main function of red blood cells?', options: ['Fight infection','Carry oxygen','Clot blood','Produce antibodies'], correctIndex: 1, explanation: 'Red blood cells carry oxygen from the lungs to the rest of the body via haemoglobin.'),
    Question(question: 'How many bones are in the human spine?', options: ['24','26','33','36'], correctIndex: 2, explanation: 'The adult spine has 33 vertebrae, though some fuse to form the sacrum and coccyx.'),
    Question(question: 'What is the speed of sound in air at room temperature?', options: ['243 m/s','343 m/s','443 m/s','543 m/s'], correctIndex: 1, explanation: 'Sound travels at approximately 343 m/s in dry air at 20°C.'),
    Question(question: 'What is the name of the process by which plants make food?', options: ['Respiration','Fermentation','Photosynthesis','Digestion'], correctIndex: 2, explanation: 'Photosynthesis converts light energy, CO₂, and water into glucose and oxygen.'),
    Question(question: 'Which planet is the densest in our solar system?', options: ['Jupiter','Saturn','Earth','Neptune'], correctIndex: 2, explanation: 'Earth is the densest planet with an average density of 5.51 g/cm³.'),
    Question(question: 'What is the chemical symbol for iron?', options: ['Ir','In','Fe','Fr'], correctIndex: 2, explanation: 'Iron\'s symbol Fe comes from the Latin word "ferrum".'),
  ];

  // ── HISTORY (25 questions) ────────────────────────────────────────────────
  static const List<Question> _history = [
    Question(question: 'In which year did World War I begin?', options: ['1912','1914','1916','1918'], correctIndex: 1, explanation: 'World War I began on 28 July 1914 following the assassination of Archduke Franz Ferdinand.'),
    Question(question: 'Who was the first President of the United States?', options: ['John Adams','Thomas Jefferson','Benjamin Franklin','George Washington'], correctIndex: 3, explanation: 'George Washington served as the first U.S. President from 1789 to 1797.'),
    Question(question: 'Which ancient wonder was located in Alexandria?', options: ['Colossus of Rhodes','Hanging Gardens','Lighthouse of Alexandria','Temple of Artemis'], correctIndex: 2, explanation: 'The Lighthouse of Alexandria stood on Pharos island and was one of the tallest structures of the ancient world.'),
    Question(question: 'In what year did the Berlin Wall fall?', options: ['1987','1988','1989','1990'], correctIndex: 2, explanation: 'The Berlin Wall fell on 9 November 1989, reuniting East and West Germany.'),
    Question(question: 'Who was the Egyptian queen famous for her relationship with Caesar and Antony?', options: ['Nefertiti','Hatshepsut','Cleopatra','Isis'], correctIndex: 2, explanation: 'Cleopatra VII had famous alliances with Julius Caesar and Mark Antony in the 1st century BC.'),
    Question(question: 'Which empire was ruled by Genghis Khan?', options: ['Ottoman Empire','Roman Empire','Mongol Empire','Persian Empire'], correctIndex: 2, explanation: 'Genghis Khan founded and ruled the Mongol Empire, the largest contiguous land empire in history.'),
    Question(question: 'In which city was the Magna Carta signed?', options: ['London','Oxford','Runnymede','Canterbury'], correctIndex: 2, explanation: 'King John signed the Magna Carta at Runnymede meadow near the River Thames in 1215.'),
    Question(question: 'Which country was the first to give women the right to vote?', options: ['Australia','UK','New Zealand','USA'], correctIndex: 2, explanation: 'New Zealand became the first self-governing country to grant women the right to vote in 1893.'),
    Question(question: 'Who discovered America in 1492?', options: ['Amerigo Vespucci','Ferdinand Magellan','Christopher Columbus','John Cabot'], correctIndex: 2, explanation: 'Christopher Columbus reached the Americas on 12 October 1492, landing in the Bahamas.'),
    Question(question: 'Which ancient civilisation built Machu Picchu?', options: ['Aztec','Maya','Olmec','Inca'], correctIndex: 3, explanation: 'The Inca Empire built Machu Picchu in the 15th century as a royal estate.'),
    Question(question: 'What year did the French Revolution begin?', options: ['1785','1787','1789','1791'], correctIndex: 2, explanation: 'The French Revolution began in 1789 with the storming of the Bastille on 14 July.'),
    Question(question: 'Who wrote the "I Have a Dream" speech?', options: ['Malcolm X','John F Kennedy','Martin Luther King Jr','Barack Obama'], correctIndex: 2, explanation: 'Martin Luther King Jr delivered this iconic civil rights speech in Washington D.C. on 28 August 1963.'),
    Question(question: 'Which ship sank on its maiden voyage in 1912?', options: ['Lusitania','Britannic','Olympic','Titanic'], correctIndex: 3, explanation: 'The RMS Titanic sank on 15 April 1912 after striking an iceberg, killing over 1,500 people.'),
    Question(question: 'What was the name of the first artificial satellite launched into space?', options: ['Explorer 1','Vostok 1','Sputnik 1','Luna 1'], correctIndex: 2, explanation: 'Sputnik 1 was launched by the Soviet Union on 4 October 1957, beginning the space age.'),
    Question(question: 'Which empire built the Colosseum in Rome?', options: ['Greek','Byzantine','Ottoman','Roman'], correctIndex: 3, explanation: 'The Roman Empire built the Colosseum between 70–80 AD under emperors Vespasian and Titus.'),
    Question(question: 'Who was the last Tsar of Russia?', options: ['Alexander III','Nicholas I','Nicholas II','Alexander II'], correctIndex: 2, explanation: 'Nicholas II was the last Russian Tsar, abdicated in 1917 and was executed in 1918.'),
    Question(question: 'Which war was fought between the North and South of the USA?', options: ['War of Independence','Civil War','Mexican-American War','Spanish-American War'], correctIndex: 1, explanation: 'The American Civil War (1861–1865) was fought between Union (North) and Confederate (South) states.'),
    Question(question: 'In which country did the Renaissance begin?', options: ['France','Spain','Germany','Italy'], correctIndex: 3, explanation: 'The Renaissance began in Italy during the 14th century, starting in Florence.'),
    Question(question: 'Who invented the printing press?', options: ['Leonardo da Vinci','Galileo Galilei','Johannes Gutenberg','Isaac Newton'], correctIndex: 2, explanation: 'Johannes Gutenberg invented the movable-type printing press around 1440 in Germany.'),
    Question(question: 'What was the name of the first man to walk on the Moon?', options: ['Buzz Aldrin','Yuri Gagarin','Neil Armstrong','John Glenn'], correctIndex: 2, explanation: 'Neil Armstrong became the first human to walk on the Moon on 20 July 1969 during Apollo 11.'),
    Question(question: 'Which country was Nelson Mandela president of?', options: ['Zimbabwe','Kenya','Nigeria','South Africa'], correctIndex: 3, explanation: 'Nelson Mandela became South Africa\'s first Black president in 1994 after 27 years in prison.'),
    Question(question: 'The Aztec Empire was located in modern-day which country?', options: ['Peru','Colombia','Brazil','Mexico'], correctIndex: 3, explanation: 'The Aztec Empire was centred in the Valley of Mexico, in present-day Mexico.'),
    Question(question: 'Who was known as the Iron Lady?', options: ['Indira Gandhi','Angela Merkel','Hillary Clinton','Margaret Thatcher'], correctIndex: 3, explanation: 'Margaret Thatcher, UK Prime Minister 1979–1990, was nicknamed the Iron Lady.'),
    Question(question: 'What ancient structure is found in Giza, Egypt?', options: ['Parthenon','Colosseum','Great Pyramid','Stonehenge'], correctIndex: 2, explanation: 'The Great Pyramid of Giza was built around 2560 BC and is the only surviving ancient wonder.'),
    Question(question: 'Which disease caused the Black Death pandemic?', options: ['Smallpox','Cholera','Bubonic plague','Typhoid'], correctIndex: 2, explanation: 'The Black Death (1347–1351) was caused by the bubonic plague bacterium Yersinia pestis.'),
  ];

  // ── SPORTS (25 questions) ─────────────────────────────────────────────────
  static const List<Question> _sports = [
    Question(question: 'How many players are on a standard football (soccer) team?', options: ['9','10','11','12'], correctIndex: 2, explanation: 'A standard football team has 11 players on the field at one time.'),
    Question(question: 'Which country has won the most FIFA World Cups?', options: ['Germany','Argentina','Italy','Brazil'], correctIndex: 3, explanation: 'Brazil has won the FIFA World Cup a record 5 times (1958, 1962, 1970, 1994, 2002).'),
    Question(question: 'How long is a standard marathon?', options: ['40 km','42.195 km','44 km','45 km'], correctIndex: 1, explanation: 'A marathon is 42.195 kilometres (26 miles and 385 yards).'),
    Question(question: 'In which sport would you perform a slam dunk?', options: ['Volleyball','Tennis','Basketball','Handball'], correctIndex: 2, explanation: 'A slam dunk is a basketball shot where a player dunks the ball directly through the hoop.'),
    Question(question: 'How many points is a try worth in rugby union?', options: ['3','4','5','6'], correctIndex: 2, explanation: 'A try in rugby union is worth 5 points, followed by a conversion worth 2 points.'),
    Question(question: 'Which country hosted the 2016 Summer Olympics?', options: ['China','UK','Russia','Brazil'], correctIndex: 3, explanation: 'Rio de Janeiro, Brazil hosted the 2016 Summer Olympics in August.'),
    Question(question: 'What is the maximum score in a single game of ten-pin bowling?', options: ['200','250','300','350'], correctIndex: 2, explanation: 'A perfect game in bowling scores 300, achieved by getting 12 consecutive strikes.'),
    Question(question: 'In tennis, what is a score of 40-40 called?', options: ['Advantage','Tie-break','Deuce','Love'], correctIndex: 2, explanation: 'When both players reach 40 points, the score is called "Deuce" and a player must win two consecutive points.'),
    Question(question: 'Who has won the most Grand Slam tennis singles titles (men)?', options: ['Roger Federer','Rafael Nadal','Pete Sampras','Novak Djokovic'], correctIndex: 3, explanation: 'Novak Djokovic holds the record with 24 Grand Slam singles titles.'),
    Question(question: 'How many events are in the Olympic decathlon?', options: ['8','9','10','12'], correctIndex: 2, explanation: 'The decathlon consists of 10 track and field events contested over two days.'),
    Question(question: 'In cricket, how many balls are in a standard over?', options: ['4','5','6','8'], correctIndex: 2, explanation: 'A cricket over consists of 6 legal deliveries bowled by one bowler.'),
    Question(question: 'Which sport uses a shuttlecock?', options: ['Squash','Racquetball','Badminton','Table Tennis'], correctIndex: 2, explanation: 'Badminton is played with a shuttlecock (also called a birdie) instead of a ball.'),
    Question(question: 'How high is an official basketball hoop from the floor?', options: ['2.9 m','3.05 m','3.2 m','3.5 m'], correctIndex: 1, explanation: 'NBA and FIBA rules set the basket height at 3.05 metres (10 feet).'),
    Question(question: 'Which country invented the sport of judo?', options: ['China','Korea','Japan','Thailand'], correctIndex: 2, explanation: 'Judo was created by Jigoro Kano in Japan in 1882 as a martial art and sport.'),
    Question(question: 'What does "LBW" stand for in cricket?', options: ['Left Bat Wicket','Leg Before Wicket','Low Ball Wide','Left Behind Wicket'], correctIndex: 1, explanation: 'LBW (Leg Before Wicket) dismisses a batsman when the ball hits the leg before hitting the bat.'),
    Question(question: 'In which sport is the Ryder Cup contested?', options: ['Tennis','Golf','Cricket','Polo'], correctIndex: 1, explanation: 'The Ryder Cup is a biennial golf competition between teams from Europe and the USA.'),
    Question(question: 'How many rings are on the Olympic flag?', options: ['4','5','6','7'], correctIndex: 1, explanation: 'The Olympic flag has 5 interlocking rings representing the five continents of the world.'),
    Question(question: 'Which sport features a pommel horse?', options: ['Gymnastics','Polo','Horse Racing','Equestrian'], correctIndex: 0, explanation: 'The pommel horse is a piece of equipment used in men\'s artistic gymnastics.'),
    Question(question: 'What is the diameter of a basketball hoop in cm?', options: ['35 cm','40 cm','45 cm','50 cm'], correctIndex: 2, explanation: 'An official basketball hoop has an inner diameter of 45.7 cm (18 inches).'),
    Question(question: 'In which country did the sport of sumo originate?', options: ['China','Mongolia','Japan','Korea'], correctIndex: 2, explanation: 'Sumo wrestling has been practised in Japan for over 1,500 years.'),
    Question(question: 'What shape is a cricket pitch?', options: ['Square','Circle','Rectangle','Oval'], correctIndex: 2, explanation: 'A cricket pitch is a rectangular strip 22 yards (20.12 m) long in the centre of the oval ground.'),
    Question(question: 'Which swimmer has won the most Olympic gold medals?', options: ['Ian Thorpe','Ryan Lochte','Mark Spitz','Michael Phelps'], correctIndex: 3, explanation: 'Michael Phelps holds the record with 23 Olympic gold medals in swimming.'),
    Question(question: 'In which sport do athletes compete in the Tour de France?', options: ['Running','Swimming','Cycling','Triathlon'], correctIndex: 2, explanation: 'The Tour de France is the world\'s most prestigious road cycling stage race.'),
    Question(question: 'How many players are on a volleyball team on court?', options: ['4','5','6','7'], correctIndex: 2, explanation: 'Volleyball is played with 6 players per team on the court.'),
    Question(question: 'What colour belt is the highest in judo?', options: ['Black','Brown','Red','White'], correctIndex: 2, explanation: 'The red belt (10th dan) is the highest rank in judo, rarely awarded.'),
  ];

  // ── TECHNOLOGY (25 questions) ─────────────────────────────────────────────
  static const List<Question> _tech = [
    Question(question: 'What does CPU stand for?', options: ['Central Processing Unit','Core Processing Unit','Central Program Unit','Computer Processing Unit'], correctIndex: 0, explanation: 'CPU stands for Central Processing Unit, the primary component that executes instructions in a computer.'),
    Question(question: 'Who co-founded Apple with Steve Jobs?', options: ['Bill Gates','Steve Wozniak','Paul Allen','Larry Page'], correctIndex: 1, explanation: 'Steve Wozniak co-founded Apple Computer with Steve Jobs and Ronald Wayne in 1976.'),
    Question(question: 'What does HTML stand for?', options: ['Hyper Text Markup Language','High Text Machine Language','Hyper Transfer Markup Language','Home Tool Markup Language'], correctIndex: 0, explanation: 'HTML (HyperText Markup Language) is the standard language for creating web pages.'),
    Question(question: 'Which company developed the Android operating system?', options: ['Apple','Microsoft','Google','Samsung'], correctIndex: 2, explanation: 'Android was developed by Android Inc., which was acquired by Google in 2005.'),
    Question(question: 'What does "www" stand for in a website URL?', options: ['World Wide Web','World Web Wide','Wide World Web','Web World Wide'], correctIndex: 0, explanation: 'WWW stands for World Wide Web, invented by Tim Berners-Lee in 1989.'),
    Question(question: 'Which programming language is known as the "language of the web"?', options: ['Python','Java','C++','JavaScript'], correctIndex: 3, explanation: 'JavaScript is the primary programming language used in web development alongside HTML and CSS.'),
    Question(question: 'What year was the first iPhone released?', options: ['2005','2006','2007','2008'], correctIndex: 2, explanation: 'Apple released the first iPhone on 29 June 2007, revolutionising the smartphone industry.'),
    Question(question: 'What does "RAM" stand for?', options: ['Random Access Memory','Read Access Memory','Rapid Access Memory','Random Application Memory'], correctIndex: 0, explanation: 'RAM (Random Access Memory) is temporary storage used by a computer to run programs.'),
    Question(question: 'Which tech giant owns YouTube?', options: ['Meta','Microsoft','Apple','Google'], correctIndex: 3, explanation: 'Google (Alphabet) acquired YouTube for \$1.65 billion in 2006.'),
    Question(question: 'What does "AI" stand for in technology?', options: ['Automated Intelligence','Artificial Intelligence','Advanced Intelligence','Applied Intelligence'], correctIndex: 1, explanation: 'AI (Artificial Intelligence) refers to computer systems designed to mimic human-like intelligence.'),
    Question(question: 'Which company made the first commercially successful personal computer?', options: ['IBM','Apple','Commodore','Tandy'], correctIndex: 0, explanation: 'The IBM PC (1981) was the first commercially successful personal computer that established industry standards.'),
    Question(question: 'What is the most popular programming language as of 2024?', options: ['Java','C++','Python','JavaScript'], correctIndex: 2, explanation: 'Python consistently ranks as the most popular programming language due to its simplicity and versatility.'),
    Question(question: 'What does "GPU" stand for?', options: ['General Processing Unit','Graphics Processing Unit','Global Processing Unit','Graphical Program Unit'], correctIndex: 1, explanation: 'GPU (Graphics Processing Unit) is a specialised processor for rendering graphics and AI computations.'),
    Question(question: 'Which protocol is used to send emails?', options: ['HTTP','FTP','SMTP','TCP'], correctIndex: 2, explanation: 'SMTP (Simple Mail Transfer Protocol) is the standard protocol for sending email messages.'),
    Question(question: 'What does "USB" stand for?', options: ['Universal Serial Bus','Unified Serial Bus','Universal System Bus','Universal Storage Bus'], correctIndex: 0, explanation: 'USB (Universal Serial Bus) is the standard connection interface for peripherals and data transfer.'),
    Question(question: 'Who is the founder of Microsoft?', options: ['Steve Jobs','Larry Ellison','Bill Gates','Mark Zuckerberg'], correctIndex: 2, explanation: 'Bill Gates co-founded Microsoft with Paul Allen in 1975.'),
    Question(question: 'What is the binary representation of the decimal number 10?', options: ['1000','1010','1100','1001'], correctIndex: 1, explanation: '10 in binary is 1010 (1×8 + 0×4 + 1×2 + 0×1 = 10).'),
    Question(question: 'What does "SSD" stand for?', options: ['Super Speed Drive','Solid State Drive','System Storage Disk','Secure Storage Device'], correctIndex: 1, explanation: 'SSD (Solid State Drive) uses flash memory to store data with no moving parts, unlike HDDs.'),
    Question(question: 'Which company developed the Java programming language?', options: ['Microsoft','Oracle','Sun Microsystems','IBM'], correctIndex: 2, explanation: 'Java was developed by James Gosling at Sun Microsystems and released in 1995.'),
    Question(question: 'What is the shortcut key to copy text on Windows?', options: ['Ctrl+X','Ctrl+V','Ctrl+C','Ctrl+A'], correctIndex: 2, explanation: 'Ctrl+C is the standard keyboard shortcut to copy selected content on Windows.'),
    Question(question: 'What does IoT stand for?', options: ['Internet of Things','Integration of Technology','Interface of Tools','Internet of Transfer'], correctIndex: 0, explanation: 'IoT (Internet of Things) refers to physical devices connected to the internet that collect and share data.'),
    Question(question: 'What is the name of the world\'s first computer programmer?', options: ['Alan Turing','Grace Hopper','Ada Lovelace','Charles Babbage'], correctIndex: 2, explanation: 'Ada Lovelace is considered the first computer programmer for her work on Babbage\'s Analytical Engine in the 1840s.'),
    Question(question: 'Which company created the Python programming language?', options: ['Google','Microsoft','MIT','Guido van Rossum / CWI'], correctIndex: 3, explanation: 'Python was created by Guido van Rossum at Centrum Wiskunde & Informatica and first released in 1991.'),
    Question(question: 'What does "VPN" stand for?', options: ['Virtual Private Network','Virtual Program Node','Verified Private Node','Virtual Public Network'], correctIndex: 0, explanation: 'VPN (Virtual Private Network) creates a secure encrypted connection over a public network.'),
    Question(question: 'How many bits are in one byte?', options: ['4','6','8','16'], correctIndex: 2, explanation: 'One byte consists of 8 bits. It is the standard unit of digital information storage.'),
  ];

  // ── GEOGRAPHY (25 questions) ──────────────────────────────────────────────
  static const List<Question> _geography = [
    Question(question: 'What is the capital of Australia?', options: ['Sydney','Melbourne','Brisbane','Canberra'], correctIndex: 3, explanation: 'Canberra is Australia\'s capital city, purpose-built and established in 1913.'),
    Question(question: 'Which is the largest country by area?', options: ['China','USA','Canada','Russia'], correctIndex: 3, explanation: 'Russia is the world\'s largest country, covering 17.1 million km².'),
    Question(question: 'Through how many countries does the River Nile flow?', options: ['9','10','11','12'], correctIndex: 2, explanation: 'The Nile flows through 11 countries, though it is most associated with Egypt and Sudan.'),
    Question(question: 'Which country has the most natural lakes?', options: ['USA','Finland','Russia','Canada'], correctIndex: 3, explanation: 'Canada has more lakes than all other countries combined, with over 2 million lakes.'),
    Question(question: 'What is the capital of Brazil?', options: ['São Paulo','Rio de Janeiro','Salvador','Brasília'], correctIndex: 3, explanation: 'Brasília has been the capital of Brazil since 1960, when it replaced Rio de Janeiro.'),
    Question(question: 'Which desert is the largest in the world?', options: ['Gobi','Sahara','Arabian','Antarctic'], correctIndex: 3, explanation: 'The Antarctic Desert is the largest at 14.2 million km², followed by the Arctic Desert.'),
    Question(question: 'What is the longest river in the world?', options: ['Amazon','Yangtze','Mississippi','Nile'], correctIndex: 3, explanation: 'The Nile is traditionally considered the longest river at approximately 6,650 km.'),
    Question(question: 'Which country has the largest population in the world?', options: ['USA','Russia','China','India'], correctIndex: 3, explanation: 'India surpassed China in 2023 to become the world\'s most populous country with 1.43 billion people.'),
    Question(question: 'On which continent is the Sahara Desert located?', options: ['Asia','South America','Australia','Africa'], correctIndex: 3, explanation: 'The Sahara Desert spans 11 countries across northern Africa.'),
    Question(question: 'What is the smallest continent by area?', options: ['Europe','Antarctica','Australia','South America'], correctIndex: 2, explanation: 'Australia (Oceania) is the smallest continent at approximately 7.7 million km².'),
    Question(question: 'Which country is known as the Land of the Rising Sun?', options: ['China','South Korea','Thailand','Japan'], correctIndex: 3, explanation: 'Japan is known as the Land of the Rising Sun; its name in Japanese, "Nihon," means "sun origin".'),
    Question(question: 'What is the capital of Canada?', options: ['Toronto','Vancouver','Montreal','Ottawa'], correctIndex: 3, explanation: 'Ottawa is the capital of Canada, located in Ontario province.'),
    Question(question: 'Which mountain range separates Europe and Asia?', options: ['Alps','Himalayas','Andes','Ural Mountains'], correctIndex: 3, explanation: 'The Ural Mountains form the natural boundary between Europe and Asia.'),
    Question(question: 'Which country has the most time zones?', options: ['Russia','China','USA','France'], correctIndex: 3, explanation: 'France has 12 time zones due to its overseas territories, more than any other country.'),
    Question(question: 'What is the deepest lake in the world?', options: ['Caspian Sea','Lake Superior','Lake Tanganyika','Lake Baikal'], correctIndex: 3, explanation: 'Lake Baikal in Russia is the deepest lake at 1,642 metres and holds 20% of the world\'s fresh water.'),
    Question(question: 'Which city is known as the Big Apple?', options: ['Los Angeles','Chicago','Houston','New York City'], correctIndex: 3, explanation: 'New York City is nicknamed the Big Apple, a term popularised in the 1920s.'),
    Question(question: 'What is the capital of South Africa\'s legislative branch?', options: ['Johannesburg','Durban','Pretoria','Cape Town'], correctIndex: 3, explanation: 'Cape Town is South Africa\'s legislative capital; Pretoria is the executive capital.'),
    Question(question: 'Which two continents does the Panama Canal connect?', options: ['North and South America','Europe and Africa','Asia and Australia','Africa and Asia'], correctIndex: 0, explanation: 'The Panama Canal connects North and South America, allowing ships to pass between the Atlantic and Pacific Oceans.'),
    Question(question: 'What is the capital of Germany?', options: ['Munich','Hamburg','Frankfurt','Berlin'], correctIndex: 3, explanation: 'Berlin is Germany\'s capital and largest city, reunified as the capital after 1990.'),
    Question(question: 'Which ocean lies between Africa and Australia?', options: ['Atlantic','Pacific','Arctic','Indian'], correctIndex: 3, explanation: 'The Indian Ocean lies between Africa, Asia, and Australia.'),
    Question(question: 'What is the highest waterfall in the world?', options: ['Niagara Falls','Iguazu Falls','Victoria Falls','Angel Falls'], correctIndex: 3, explanation: 'Angel Falls in Venezuela is the world\'s highest uninterrupted waterfall at 979 metres.'),
    Question(question: 'Which country is both a continent and a country?', options: ['Greenland','Iceland','New Zealand','Australia'], correctIndex: 3, explanation: 'Australia is unique in being both a continent and a sovereign country.'),
    Question(question: 'What is the capital of Japan?', options: ['Osaka','Kyoto','Hiroshima','Tokyo'], correctIndex: 3, explanation: 'Tokyo has been the capital of Japan since 1869 and is the world\'s most populous metropolitan area.'),
    Question(question: 'Which river flows through London?', options: ['Avon','Severn','Trent','Thames'], correctIndex: 3, explanation: 'The River Thames flows through London and is the longest river entirely in England at 346 km.'),
    Question(question: 'How many countries are in Africa?', options: ['48','50','54','58'], correctIndex: 2, explanation: 'Africa has 54 recognised sovereign countries, making it the continent with the most countries.'),
  ];


  // ── MUSIC (25 questions) ─────────────────────────────────────────────────
  static const List<Question> _music = [
    Question(question: 'Who is known as the "King of Pop"?', options: ['Elvis Presley','Prince','Michael Jackson','David Bowie'], correctIndex: 2, explanation: 'Michael Jackson earned the title King of Pop for his massive global influence on pop music.'),
    Question(question: 'How many strings does a violin have?', options: ['3','4','5','6'], correctIndex: 1, explanation: 'A standard violin has 4 strings tuned G, D, A, E from lowest to highest.'),
    Question(question: 'Which band sang "Bohemian Rhapsody"?', options: ['The Beatles','Led Zeppelin','Queen','Rolling Stones'], correctIndex: 2, explanation: 'Bohemian Rhapsody was released by Queen in 1975 and written by Freddie Mercury.'),
    Question(question: 'What is the fastest tempo marking in music?', options: ['Presto','Prestissimo','Vivace','Allegro'], correctIndex: 1, explanation: 'Prestissimo is the fastest standard tempo marking, typically above 200 beats per minute.'),
    Question(question: 'Which instrument is Yo-Yo Ma famous for playing?', options: ['Piano','Violin','Cello','Double Bass'], correctIndex: 2, explanation: 'Yo-Yo Ma is one of the world\'s greatest cellists, born in France to Chinese parents.'),
    Question(question: 'How many keys does a standard piano have?', options: ['76','82','88','96'], correctIndex: 2, explanation: 'A standard modern piano has 88 keys: 52 white and 36 black.'),
    Question(question: 'Who composed "Für Elise"?', options: ['Mozart','Bach','Beethoven','Chopin'], correctIndex: 2, explanation: 'Für Elise (Bagatelle No. 25) was composed by Ludwig van Beethoven around 1810.'),
    Question(question: 'What is the lowest male singing voice called?', options: ['Tenor','Baritone','Bass','Countertenor'], correctIndex: 2, explanation: 'Bass is the lowest male singing voice, typically ranging from E2 to E4.'),
    Question(question: 'Which country does the musical genre Reggae originate from?', options: ['Cuba','Trinidad','Brazil','Jamaica'], correctIndex: 3, explanation: 'Reggae originated in Jamaica in the late 1960s, popularised globally by Bob Marley.'),
    Question(question: 'What does "forte" mean in music?', options: ['Soft','Very soft','Loud','Very loud'], correctIndex: 2, explanation: 'Forte (f) is an Italian musical term meaning loud or strong.'),
    Question(question: 'Which Beatles member wrote "Yesterday"?', options: ['John Lennon','George Harrison','Ringo Starr','Paul McCartney'], correctIndex: 3, explanation: 'Yesterday was written by Paul McCartney and is one of the most covered songs in history.'),
    Question(question: 'What is the time signature of a waltz?', options: ['2/4','4/4','3/4','6/8'], correctIndex: 2, explanation: 'A waltz is in 3/4 time, meaning 3 beats per measure with a quarter note getting one beat.'),
    Question(question: 'Which instrument is associated with jazz musician Miles Davis?', options: ['Saxophone','Trumpet','Trombone','Clarinet'], correctIndex: 1, explanation: 'Miles Davis was a legendary jazz trumpeter whose influential style shaped jazz for decades.'),
    Question(question: 'What genre of music is associated with Nashville, Tennessee?', options: ['Blues','Jazz','Hip-hop','Country'], correctIndex: 3, explanation: 'Nashville is known as the home of country music and houses the Country Music Hall of Fame.'),
    Question(question: 'Who sang "Rolling in the Deep"?', options: ['Beyoncé','Taylor Swift','Adele','Rihanna'], correctIndex: 2, explanation: 'Rolling in the Deep was released by Adele in 2010 on her album 21.'),
    Question(question: 'What is the name of the opening of a classical symphony?', options: ['Coda','Rondo','Overture','Prelude'], correctIndex: 2, explanation: 'An overture is an orchestral introduction to a larger work like an opera or symphony.'),
    Question(question: 'How many movements does a traditional symphony have?', options: ['2','3','4','5'], correctIndex: 2, explanation: 'A classical symphony typically has 4 movements with varying tempos and characters.'),
    Question(question: 'Which music streaming platform has the most monthly users?', options: ['Apple Music','Amazon Music','Tidal','Spotify'], correctIndex: 3, explanation: 'Spotify is the world\'s most popular music streaming service with over 600 million monthly active users.'),
    Question(question: 'What does "BPM" stand for in music?', options: ['Bass Per Minute','Beats Per Measure','Beats Per Minute','Bass Per Measure'], correctIndex: 2, explanation: 'BPM (Beats Per Minute) measures the tempo of music.'),
    Question(question: 'Which music award is given for classical music?', options: ['Grammy','Mercury Prize','Brit Award','Classical Brit'], correctIndex: 3, explanation: 'The Classical BRIT Awards honour outstanding classical music recordings and performances.'),
    Question(question: 'What is the highest female singing voice?', options: ['Alto','Mezzo-soprano','Soprano','Contralto'], correctIndex: 2, explanation: 'Soprano is the highest female singing voice, typically ranging from C4 to C6.'),
    Question(question: 'Who composed the "Four Seasons"?', options: ['Bach','Handel','Vivaldi','Telemann'], correctIndex: 2, explanation: 'The Four Seasons is a set of four violin concertos composed by Antonio Vivaldi around 1720.'),
    Question(question: 'What is the national instrument of Spain?', options: ['Violin','Flute','Classical Guitar','Mandolin'], correctIndex: 2, explanation: 'The classical guitar is closely associated with Spanish music and culture.'),
    Question(question: 'Which music interval has a ratio of 2:1?', options: ['Fifth','Third','Octave','Fourth'], correctIndex: 2, explanation: 'An octave has a frequency ratio of exactly 2:1, doubling the pitch.'),
    Question(question: 'What type of voice did Pavarotti have?', options: ['Baritone','Tenor','Bass','Bass-baritone'], correctIndex: 1, explanation: 'Luciano Pavarotti was a world-famous Italian tenor, renowned for his powerful and clear voice.'),
  ];

  // ── NATURE & ANIMALS (25 questions) ──────────────────────────────────────
  static const List<Question> _nature = [
    Question(question: 'What is the fastest land animal?', options: ['Lion','Cheetah','Leopard','Greyhound'], correctIndex: 1, explanation: 'The cheetah can reach speeds of up to 112 km/h, making it the fastest land animal.'),
    Question(question: 'How many legs does a spider have?', options: ['6','7','8','10'], correctIndex: 2, explanation: 'All spiders are arachnids and have 8 legs, distinguishing them from 6-legged insects.'),
    Question(question: 'What is a group of lions called?', options: ['Pack','Herd','Pride','Flock'], correctIndex: 2, explanation: 'A group of lions living together is called a pride, typically consisting of related females and their young.'),
    Question(question: 'Which animal has the longest lifespan?', options: ['Elephant','Tortoise','Whale','Parrot'], correctIndex: 1, explanation: 'Tortoises have the longest confirmed lifespan of any land animal, often exceeding 150 years.'),
    Question(question: 'What is the largest rainforest in the world?', options: ['Congo','Borneo','Daintree','Amazon'], correctIndex: 3, explanation: 'The Amazon Rainforest covers 5.5 million km² across South America and contains 10% of all species on Earth.'),
    Question(question: 'How do bees communicate the location of flowers?', options: ['Clicking','Scent trails','Waggle dance','Colour signals'], correctIndex: 2, explanation: 'Honeybees perform a "waggle dance" to communicate the direction and distance of food sources.'),
    Question(question: 'Which bird is known for mimicking human speech?', options: ['Canary','Robin','Parrot','Pigeon'], correctIndex: 2, explanation: 'Parrots, especially African Grey Parrots, are renowned for their ability to mimic human speech.'),
    Question(question: 'What is the largest species of shark?', options: ['Great White','Bull Shark','Tiger Shark','Whale Shark'], correctIndex: 3, explanation: 'The whale shark is the largest fish and shark species, reaching up to 18 metres in length.'),
    Question(question: 'How many hearts does an octopus have?', options: ['1','2','3','4'], correctIndex: 2, explanation: 'An octopus has 3 hearts: two pump blood to the gills, and one pumps it to the rest of the body.'),
    Question(question: 'What do you call the study of birds?', options: ['Entomology','Herpetology','Ornithology','Ichthyology'], correctIndex: 2, explanation: 'Ornithology is the branch of zoology that deals with the study of birds.'),
    Question(question: 'Which animal is the tallest in the world?', options: ['Elephant','Giraffe','Camel','Polar Bear'], correctIndex: 1, explanation: 'Giraffes are the tallest living animals, with males reaching up to 6 metres in height.'),
    Question(question: 'What is the name for a baby kangaroo?', options: ['Cub','Calf','Foal','Joey'], correctIndex: 3, explanation: 'A baby kangaroo is called a joey. It lives in its mother\'s pouch for up to a year.'),
    Question(question: 'What percentage of the Earth is covered by water?', options: ['51%','61%','71%','81%'], correctIndex: 2, explanation: 'Approximately 71% of Earth\'s surface is covered by water, mostly the world\'s oceans.'),
    Question(question: 'Which gas makes up most of the sun?', options: ['Helium','Oxygen','Hydrogen','Nitrogen'], correctIndex: 2, explanation: 'The Sun is approximately 73% hydrogen and 25% helium by mass.'),
    Question(question: 'What is the process by which a caterpillar becomes a butterfly?', options: ['Evolution','Germination','Metamorphosis','Hibernation'], correctIndex: 2, explanation: 'Metamorphosis is the biological process of transformation from larva (caterpillar) to adult (butterfly).'),
    Question(question: 'Which animal can survive for the longest without water?', options: ['Camel','Kangaroo Rat','Giraffe','Fennec Fox'], correctIndex: 1, explanation: 'The kangaroo rat can survive without drinking water by metabolising seeds and never sweating.'),
    Question(question: 'What is the name of the layer of gases surrounding Earth?', options: ['Biosphere','Hydrosphere','Lithosphere','Atmosphere'], correctIndex: 3, explanation: 'The atmosphere is the layer of gases held by Earth\'s gravity, protecting life and regulating temperature.'),
    Question(question: 'Which insect produces honey?', options: ['Wasp','Ant','Butterfly','Bee'], correctIndex: 3, explanation: 'Honeybees produce honey by collecting and processing nectar from flowers.'),
    Question(question: 'What type of animal is a Komodo dragon?', options: ['Snake','Crocodile','Lizard','Turtle'], correctIndex: 2, explanation: 'The Komodo dragon is the world\'s largest lizard, native to Indonesian islands.'),
    Question(question: 'What is the largest organ in the human body?', options: ['Liver','Brain','Lungs','Skin'], correctIndex: 3, explanation: 'The skin is the largest organ, covering approximately 1.7–2.0 m² in adults.'),
    Question(question: 'Which tree produces acorns?', options: ['Maple','Pine','Oak','Birch'], correctIndex: 2, explanation: 'Acorns are the nuts of oak trees (genus Quercus) and are an important food source for many animals.'),
    Question(question: 'What is the term for an animal that eats both plants and meat?', options: ['Herbivore','Carnivore','Omnivore','Insectivore'], correctIndex: 2, explanation: 'Omnivores eat both plants and animals. Humans are omnivores.'),
    Question(question: 'How do sharks detect prey in the water?', options: ['Echolocation','Electroreception','Infrared vision','Sonar clicks'], correctIndex: 1, explanation: 'Sharks use electroreception via organs called ampullae of Lorenzini to detect electric fields.'),
    Question(question: 'Which animal is the symbol of the World Wildlife Fund (WWF)?', options: ['Polar Bear','Tiger','Giant Panda','Snow Leopard'], correctIndex: 2, explanation: 'The giant panda has been WWF\'s logo since the organisation was founded in 1961.'),
    Question(question: 'What is the primary source of energy for nearly all life on Earth?', options: ['Wind','Water','The Moon','The Sun'], correctIndex: 3, explanation: 'The Sun provides energy through sunlight, which is captured by plants via photosynthesis and enters the food chain.'),
  ];

  // ── FOOD & COOKING (25 questions) ────────────────────────────────────────
  static const List<Question> _food = [
    Question(question: 'Which country is sushi originally from?', options: ['China','Thailand','South Korea','Japan'], correctIndex: 3, explanation: 'Sushi originated in Japan. Modern nigiri sushi developed in Tokyo in the early 19th century.'),
    Question(question: 'What is the main ingredient in guacamole?', options: ['Tomato','Onion','Lime','Avocado'], correctIndex: 3, explanation: 'Guacamole is made primarily from mashed avocados, originating from Mexican cuisine.'),
    Question(question: 'Which spice comes from the dried stigmas of the Crocus flower?', options: ['Turmeric','Paprika','Saffron','Cardamom'], correctIndex: 2, explanation: 'Saffron is harvested from Crocus sativus flowers and is the world\'s most expensive spice by weight.'),
    Question(question: 'What type of pastry is used to make a croissant?', options: ['Shortcrust','Choux','Filo','Puff'], correctIndex: 3, explanation: 'Croissants are made with laminated puff pastry dough, created through a process of folding butter into dough.'),
    Question(question: 'What is the Italian word for "dough" in pizza context?', options: ['Pasta','Impasto','Farina','Crosta'], correctIndex: 1, explanation: '"Impasto" is the Italian word for dough used in pizza and bread making.'),
    Question(question: 'Which country does the dish "Pad Thai" come from?', options: ['Vietnam','Cambodia','Indonesia','Thailand'], correctIndex: 3, explanation: 'Pad Thai is a stir-fried noodle dish that is one of Thailand\'s national dishes.'),
    Question(question: 'What is the primary ingredient in hummus?', options: ['Lentils','Black beans','Chickpeas','Fava beans'], correctIndex: 2, explanation: 'Hummus is made from blended chickpeas (garbanzo beans), tahini, lemon juice, and garlic.'),
    Question(question: 'Which nut is used to make marzipan?', options: ['Walnut','Hazelnut','Almond','Cashew'], correctIndex: 2, explanation: 'Marzipan is made from ground almonds, sugar, and sometimes egg whites.'),
    Question(question: 'What is the base spirit in a Margarita cocktail?', options: ['Rum','Vodka','Gin','Tequila'], correctIndex: 3, explanation: 'A Margarita is made with tequila, lime juice, and triple sec or orange liqueur.'),
    Question(question: 'What type of bean is chocolate made from?', options: ['Coffee bean','Vanilla bean','Cacao bean','Castor bean'], correctIndex: 2, explanation: 'Chocolate is made from cacao beans (Theobroma cacao), which are fermented, dried, roasted, and processed.'),
    Question(question: 'What is the national dish of England?', options: ['Roast Beef','Chicken Tikka Masala','Fish and Chips','Shepherd\'s Pie'], correctIndex: 1, explanation: 'Chicken Tikka Masala is widely considered Britain\'s most popular dish and has been called the "national dish".'),
    Question(question: 'What cooking method is used to make a crème brûlée topping?', options: ['Grilling','Flambéing','Torching','Broiling'], correctIndex: 2, explanation: 'The caramelised sugar topping of crème brûlée is made by torching sugar with a kitchen blowtorch.'),
    Question(question: 'Which vitamin is most abundant in citrus fruits?', options: ['Vitamin A','Vitamin B12','Vitamin C','Vitamin D'], correctIndex: 2, explanation: 'Citrus fruits like oranges and lemons are rich in Vitamin C (ascorbic acid).'),
    Question(question: 'What is "al dente" when cooking pasta?', options: ['Overcooked','Fully cooked','Very soft','Firm to the bite'], correctIndex: 3, explanation: 'Al dente is Italian for "to the tooth" — pasta cooked firm and slightly resistant when bitten.'),
    Question(question: 'Which country produces the most tea in the world?', options: ['India','Sri Lanka','Japan','China'], correctIndex: 3, explanation: 'China is the world\'s largest tea producer, accounting for nearly 45% of global production.'),
    Question(question: 'What is the main ingredient in a traditional Spanish paella?', options: ['Pasta','Couscous','Quinoa','Rice'], correctIndex: 3, explanation: 'Paella is a Spanish rice dish, originally from Valencia, cooked in a wide flat pan.'),
    Question(question: 'What type of food is Brie?', options: ['Yoghurt','Butter','Cream','Cheese'], correctIndex: 3, explanation: 'Brie is a soft cow\'s milk cheese originating from the Brie region of France.'),
    Question(question: 'How many calories are in one gram of fat?', options: ['4','7','9','11'], correctIndex: 2, explanation: 'Fat contains 9 calories per gram, compared to 4 calories per gram for protein and carbohydrates.'),
    Question(question: 'Which cooking technique involves submerging food in hot fat?', options: ['Sautéing','Braising','Deep-frying','Poaching'], correctIndex: 2, explanation: 'Deep-frying submerges food in hot oil (typically 160–190°C) to cook it quickly and create a crispy exterior.'),
    Question(question: 'What is the key ingredient that makes bread rise?', options: ['Sugar','Salt','Baking powder','Yeast'], correctIndex: 3, explanation: 'Yeast ferments sugars in dough, producing CO₂ gas bubbles that cause bread to rise.'),
    Question(question: 'Which country is known for inventing Champagne?', options: ['Italy','Germany','Spain','France'], correctIndex: 3, explanation: 'Champagne is a sparkling wine produced in the Champagne region of northeastern France.'),
    Question(question: 'What is the main flavour in a traditional Tiramisu?', options: ['Chocolate','Vanilla','Coffee','Almond'], correctIndex: 2, explanation: 'Tiramisu is an Italian dessert made with coffee-soaked ladyfingers, mascarpone, and cocoa.'),
    Question(question: 'Which grain is used to make traditional Japanese sake?', options: ['Wheat','Barley','Rice','Millet'], correctIndex: 2, explanation: 'Sake is a Japanese rice wine brewed by fermenting polished rice.'),
    Question(question: 'What is the Scoville scale used to measure?', options: ['Acidity of lemons','Sweetness of fruit','Bitterness of coffee','Spiciness of chillies'], correctIndex: 3, explanation: 'The Scoville scale measures the pungency (spiciness) of chilli peppers and hot sauces.'),
    Question(question: 'Which country invented the hamburger?', options: ['UK','Australia','Germany','USA'], correctIndex: 3, explanation: 'The hamburger as we know it was popularised in the USA in the late 19th century, though it has roots in Hamburg, Germany.'),
  ];


  // ── MOVIES & ENTERTAINMENT (25 questions) ────────────────────────────────
  static const List<Question> _movies = [
    Question(question: 'Which film won the first Academy Award for Best Picture?', options: ['Sunrise','Wings','The Jazz Singer','Ben-Hur'], correctIndex: 1, explanation: 'Wings (1927) was the first film to win the Academy Award for Best Picture at the inaugural ceremony in 1929.'),
    Question(question: 'Who directed the movie "Jurassic Park"?', options: ['James Cameron','George Lucas','Steven Spielberg','Ridley Scott'], correctIndex: 2, explanation: 'Jurassic Park (1993) was directed by Steven Spielberg and is based on Michael Crichton\'s novel.'),
    Question(question: 'Which animated film features the song "Let It Go"?', options: ['Moana','Tangled','Brave','Frozen'], correctIndex: 3, explanation: 'Let It Go is the signature song from Disney\'s Frozen (2013), sung by the character Elsa.'),
    Question(question: 'What is the highest-grossing film of all time?', options: ['Titanic','Avengers: Endgame','Avatar','Star Wars: The Force Awakens'], correctIndex: 2, explanation: 'Avatar (2009, re-released 2022) is the highest-grossing film of all time with over \$2.9 billion.'),
    Question(question: 'Who played Iron Man in the Marvel Cinematic Universe?', options: ['Chris Evans','Chris Hemsworth','Robert Downey Jr','Mark Ruffalo'], correctIndex: 2, explanation: 'Robert Downey Jr portrayed Tony Stark / Iron Man in the MCU from 2008 to 2019.'),
    Question(question: 'In which year was the first Star Wars film released?', options: ['1975','1976','1977','1978'], correctIndex: 2, explanation: 'Star Wars (Episode IV: A New Hope) was released on 25 May 1977, directed by George Lucas.'),
    Question(question: 'What is the name of the main character in The Lion King?', options: ['Mufasa','Nala','Pumba','Simba'], correctIndex: 3, explanation: 'Simba is the lion cub protagonist of Disney\'s The Lion King (1994).'),
    Question(question: 'Which country produces the most films per year?', options: ['USA','China','Nigeria','India'], correctIndex: 3, explanation: 'India\'s film industry (Bollywood and others) produces around 1,800–2,000 films per year, more than any country.'),
    Question(question: 'Who played the character "Forrest Gump"?', options: ['Tom Hanks','Mel Gibson','Kevin Costner','Bill Murray'], correctIndex: 0, explanation: 'Tom Hanks won his second consecutive Academy Award for Best Actor for his role in Forrest Gump (1994).'),
    Question(question: 'What is the fictional African nation in Black Panther?', options: ['Zamunda','Genovia','Wakanda','Narnia'], correctIndex: 2, explanation: 'Wakanda is the fictional African nation and home of T\'Challa / Black Panther in the Marvel Universe.'),
    Question(question: 'Which director is known for films like "Inception" and "Interstellar"?', options: ['Wes Anderson','David Fincher','Denis Villeneuve','Christopher Nolan'], correctIndex: 3, explanation: 'Christopher Nolan is known for complex, visually stunning films including Inception, The Dark Knight, and Interstellar.'),
    Question(question: 'How many films are in the original Star Wars trilogy?', options: ['2','3','4','6'], correctIndex: 1, explanation: 'The original Star Wars trilogy consists of 3 films: A New Hope (1977), The Empire Strikes Back (1980), and Return of the Jedi (1983).'),
    Question(question: 'What is the name of the dwarf played by Peter Dinklage in Game of Thrones?', options: ['Cersei','Tyrion Lannister','Jon Snow','Joffrey'], correctIndex: 1, explanation: 'Peter Dinklage played Tyrion Lannister, winning four Emmy Awards for the role.'),
    Question(question: 'In which city does the TV show "Friends" take place?', options: ['Los Angeles','Boston','Chicago','New York City'], correctIndex: 3, explanation: 'Friends (1994–2004) is set in New York City, with characters living in fictional apartments in Manhattan.'),
    Question(question: 'What animated studio produced "Toy Story"?', options: ['DreamWorks','Blue Sky','Illumination','Pixar'], correctIndex: 3, explanation: 'Toy Story (1995) was produced by Pixar Animation Studios and was the first fully computer-animated feature film.'),
    Question(question: 'Who is the author of the Harry Potter book series?', options: ['Stephenie Meyer','Philip Pullman','Roald Dahl','J.K. Rowling'], correctIndex: 3, explanation: 'J.K. Rowling wrote the seven Harry Potter novels published between 1997 and 2007.'),
    Question(question: 'What is the highest possible score in the game of bowling?', options: ['250','275','300','350'], correctIndex: 2, explanation: 'A perfect game in bowling is 300 points, achieved by 12 consecutive strikes.'),
    Question(question: 'Which streaming service produced "Stranger Things"?', options: ['HBO','Amazon Prime','Disney+','Netflix'], correctIndex: 3, explanation: 'Stranger Things is an original series produced by Netflix, first released in July 2016.'),
    Question(question: 'What is the name of Batman\'s butler?', options: ['James','Gordon','Alfred','Lucius'], correctIndex: 2, explanation: 'Alfred Pennyworth is Bruce Wayne\'s loyal butler and confidant in the Batman universe.'),
    Question(question: 'Which famous actor played Jack Sparrow in Pirates of the Caribbean?', options: ['Brad Pitt','Orlando Bloom','Will Smith','Johnny Depp'], correctIndex: 3, explanation: 'Johnny Depp played Captain Jack Sparrow across 5 Pirates of the Caribbean films (2003–2017).'),
    Question(question: 'What genre is the TV series "Breaking Bad"?', options: ['Sci-fi','Comedy','Crime drama','Fantasy'], correctIndex: 2, explanation: 'Breaking Bad is a crime drama series created by Vince Gilligan that aired on AMC from 2008 to 2013.'),
    Question(question: 'Who voiced Woody in the Toy Story films?', options: ['Tim Allen','John Goodman','Billy Crystal','Tom Hanks'], correctIndex: 3, explanation: 'Tom Hanks has voiced Woody the cowboy in all four Toy Story films (1995–2019).'),
    Question(question: 'In the movie "The Wizard of Oz", what are Dorothy\'s shoes made of?', options: ['Glass','Silver','Crystal','Ruby'], correctIndex: 3, explanation: 'In the 1939 film, Dorothy wears ruby slippers, though they were silver shoes in the original L. Frank Baum novel.'),
    Question(question: 'Which 2019 film won the Academy Award for Best Picture?', options: ['1917','Joker','Once Upon a Time in Hollywood','Parasite'], correctIndex: 3, explanation: 'Parasite (2019) by South Korean director Bong Joon-ho became the first non-English film to win Best Picture.'),
    Question(question: 'How many seasons did the TV show "Breaking Bad" have?', options: ['3','4','5','6'], correctIndex: 2, explanation: 'Breaking Bad ran for 5 seasons (2008–2013), consisting of 62 episodes in total.'),
  ];

  // ── CATEGORIES ─────────────────────────────────────────────────────────────
  static final List<QuizCategory> categories = [
    QuizCategory(
      id: 'general',
      name: 'General Knowledge',
      emoji: '🌍',
      description: 'Test your knowledge across a wide range of topics.',
      levels: _buildLevels(_general),
    ),
    QuizCategory(
      id: 'science',
      name: 'Science',
      emoji: '🔬',
      description: 'Explore the wonders of science and technology.',
      levels: _buildLevels(_science),
    ),
    QuizCategory(
      id: 'history',
      name: 'History',
      emoji: '🏛️',
      description: 'Journey through the annals of human history.',
      levels: _buildLevels(_history),
    ),
    QuizCategory(
      id: 'sports',
      name: 'Sports',
      emoji: '⚽',
      description: 'How well do you know the world of sports?',
      levels: _buildLevels(_sports),
    ),
    QuizCategory(
      id: 'tech',
      name: 'Technology',
      emoji: '💻',
      description: 'Dive into the digital world of technology.',
      levels: _buildLevels(_tech),
    ),
    QuizCategory(
      id: 'geography',
      name: 'Geography',
      emoji: '🗺️',
      description: 'Explore countries, capitals and landscapes.',
      levels: _buildLevels(_geography),
    ),
    QuizCategory(
      id: 'music',
      name: 'Music',
      emoji: '🎵',
      description: 'Test your knowledge of music, artists and instruments.',
      levels: _buildLevels(_music),
    ),
    QuizCategory(
      id: 'nature',
      name: 'Nature & Animals',
      emoji: '🌿',
      description: 'Discover the wonders of the natural world.',
      levels: _buildLevels(_nature),
    ),
    QuizCategory(
      id: 'food',
      name: 'Food & Cooking',
      emoji: '🍳',
      description: 'A delicious quiz about food, flavours and cooking.',
      levels: _buildLevels(_food),
    ),
    QuizCategory(
      id: 'movies',
      name: 'Movies & Entertainment',
      emoji: '🎬',
      description: 'Lights, camera, action! Test your cinema knowledge.',
      levels: _buildLevels(_movies),
    ),
  ];

  // Distribute 25 questions across 10 levels (2-3 questions per level)
  static List<Level> _buildLevels(List<Question> questions) {
    final difficulties = [
      'Beginner', 'Beginner', 'Easy', 'Easy',
      'Medium', 'Medium', 'Hard', 'Hard',
      'Expert', 'Master',
    ];
    final titles = [
      'Getting Started', 'Warm Up', 'Rising Star', 'On Track',
      'Halfway There', 'Sharp Mind', 'Brain Teaser', 'Knowledge Seeker',
      'Expert Zone', 'Master Class',
    ];
    final times = [30, 30, 25, 25, 20, 20, 15, 15, 12, 10];

    // Spread 25 questions: levels 0-9 get [3,3,3,3,2,3,2,3,2,1] → actually do 3,3,2,3,2,3,2,3,2,2
    final splits = [3, 3, 3, 3, 2, 3, 2, 3, 1, 2];
    int start = 0;
    return List.generate(10, (i) {
      final count = splits[i];
      final levelQs = questions.sublist(start, (start + count).clamp(0, questions.length));
      start += count;
      return Level(
        levelNumber: i + 1,
        title: titles[i],
        difficulty: difficulties[i],
        questions: levelQs,
        timePerQuestion: times[i],
      );
    });
  }

  // ── LEADERBOARD DATA ───────────────────────────────────────────────────────
  static const List<LeaderboardEntry> leaderboard = [
    LeaderboardEntry(name: 'Sophia Cho',       score: 888, avatar: '👩',     rank: 1),
    LeaderboardEntry(name: 'Emma Ema',          score: 808, avatar: '🧑',     rank: 2),
    LeaderboardEntry(name: 'Andrew W',          score: 800, avatar: '👨',     rank: 3),
    LeaderboardEntry(name: 'Raya Sadewa',       score: 298, avatar: '👩‍🦱', rank: 4),
    LeaderboardEntry(name: 'Olivia Ava',        score: 256, avatar: '👧',     rank: 5),
    LeaderboardEntry(name: 'David Joshua',      score: 212, avatar: '👦',     rank: 6),
    LeaderboardEntry(name: 'Charlotte Harper',  score: 181, avatar: '👩‍🦰', rank: 7),
    LeaderboardEntry(name: 'Mia Evelyn',        score: 120, avatar: '🧑‍🦱', rank: 8),
  ];
}
