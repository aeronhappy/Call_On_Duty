import 'package:call_on_duty/model/answer_model.dart';
import 'package:call_on_duty/types/question_difficulty.dart';
import '../model/question_model.dart';

abstract class IQuestionRepository {
  Future<List<QuestionModel>> getRandomQuestions(
      QuestionDifficulty questionDifficulty);
  Future<List<QuestionDifficulty>> getMode();
}

class QuestionRepository implements IQuestionRepository {
  @override
  Future<List<QuestionModel>> getRandomQuestions(
      QuestionDifficulty questionDifficulty) async {
    try {
      List<QuestionModel> newQuestions = [];
      listOfQuestion.shuffle();
      for (var item in listOfQuestion) {
        if (item.difficulty == questionDifficulty) {
          newQuestions.add(item);
        }
      }

      for (var item in newQuestions) {
        item.choices.shuffle();
      }
      return newQuestions;
    } on Exception catch (_) {
      throw UnimplementedError();
    }
  }

  @override
  Future<List<QuestionDifficulty>> getMode() async {
    try {
      List<QuestionDifficulty> mode = [
        QuestionDifficulty.lesson_1,
        QuestionDifficulty.lesson_2,
        QuestionDifficulty.lesson_3
      ];
      return mode;
    } on Exception catch (_) {
      throw UnimplementedError();
    }
  }

  List<QuestionModel> listOfQuestion = [
    /// LESSON1
    QuestionModel(
        id: 'q1',
        title: 'asthma',
        text:
            'Ang asthma o hika ay isang kondisyon na nakakaapekto sa daanan ng hangin sa respiratory system ng isang tao. Ito ay nagdudulot ng kakapusan ng hininga (shortness of breath). Sa kabilang banda, ang asthma ay isang malakas na reaksyon ng immune system sa isang substance tulad ng allergen. Ang reaksyong ito ay humahantong sa pamamaga at pagpapaliit ng mga daanan ng hangin sa mga baga.',
        difficulty: QuestionDifficulty.lesson_1,
        video: 'assets/video_question/L1_asthma.mp4',
        answersId: [
          'a1',
          'a2'
        ],
        choices: <AnswerModel>[
          const AnswerModel(
              id: 'a1',
              value: 'Rest',
              image: 'assets/image_choices/rest.png',
              explanation:
                  'humanap ng mauupuan na kung saan pwede ka na makapahinga at maging komportable.',
              video: 'assets/video_answer/L1_asthma_1.mp4'),
          const AnswerModel(
              id: 'a2',
              value: 'Inhaler',
              image: 'assets/image_choices/inhaler.png',
              explanation:
                  'gumamit ng inhaler upang makatulong ito sa pag papaluwag ng pag hinga',
              video: 'assets/video_answer/L1_asthma_2.mp4'),
          const AnswerModel(
              id: 'a3',
              value: 'ice',
              image: 'assets/image_choices/ice.png',
              explanation: '',
              video: ''),
          const AnswerModel(
              id: 'a4',
              value: 'Hot Water',
              image: 'assets/image_choices/hot_water.png',
              explanation: '',
              video: ''),
        ]),
    QuestionModel(
      id: 'q2',
      title: 'fever',
      text:
          'Ang lagnat ay isang malawak na kondisyon na naglalarawan sa pagtaas o pag-init ng temperatura ng katawan (mas mataas pa sa 37.8 degrees Celsius Bagamat ito ay kilala bilang isang uri ng karamdaman, hindi dapat ituring na sakit ang lagnat. ',
      difficulty: QuestionDifficulty.lesson_1,
      video: 'assets/video_question/L1_fever.mp4',
      answersId: ['a1', 'a2'],
      choices: <AnswerModel>[
        const AnswerModel(
            id: 'a1',
            value: 'Paracetamol',
            image: 'assets/image_choices/medicine.png',
            explanation:
                'uminom ng paracetamol upang dahil ang paracetamol ay isang uri analgesic at antipyretic na gamot na mabisa para maibsan ang nararamdamang pananakit sa katawan at mapababa ang lagnat.',
            video: 'assets/video_answer/L1_fever_1.mp4'),
        const AnswerModel(
            id: 'a2',
            value: 'Rest',
            image: 'assets/image_choices/rest.png',
            explanation:
                'kinakailangan na makapahinga ang isang taong may lagnat dahil ito ay mahalaga upang ang lagnat ay kaagad na mawala.',
            video: 'assets/video_answer/L1_fever_2.mp4'),
        const AnswerModel(
            id: 'a3',
            value: 'Bandage',
            image: 'assets/image_choices/bandage.png',
            explanation: '',
            video: ''),
        const AnswerModel(
            id: 'a4',
            value: 'Ointment',
            image: 'assets/image_choices/ointment.png',
            explanation: '',
            video: ''),
      ],
    ),
    QuestionModel(
      id: 'q3',
      title: 'cuts and bruises',
      text:
          'Ang mga cuts and bruises ay karaniwang pinsala kabilang dito ang mga sugat tulad ng mga lacerations, puncture wounds, o gasgas.',
      difficulty: QuestionDifficulty.lesson_1,
      video: 'assets/video_question/L1_cuts.mp4',
      answersId: ['a1', 'a2'],
      choices: <AnswerModel>[
        const AnswerModel(
            id: 'a1',
            value: 'Water',
            image: 'assets/image_choices/wash with water.png',
            explanation:
                'kinakailangan na malinis ng tubig ang isang isang sugat upang maiwasan ang panganib ng impeksyon.',
            video: 'assets/video_answer/L1_cuts_1.mp4'),
        const AnswerModel(
            id: 'a2',
            value: 'Blister pad',
            image: 'assets/image_choices/blister_pad.png',
            explanation:
                'takpan ang mismong wound o sugat ng dressing upang makaiwas sa mga dumi o alikabok at upang mapigilan ang pagdudurugo ng sugat. ',
            video: 'assets/video_answer/L1_cuts_2.mp4'),
        const AnswerModel(
            id: 'a3',
            value: 'Blanket',
            image: 'assets/image_choices/blanket.png',
            explanation: '',
            video: ''),
        const AnswerModel(
            id: 'a4',
            value: 'Mouth Spray',
            image: 'assets/image_choices/mouth_spray.png',
            explanation: '',
            video: ''),
      ],
    ),
    QuestionModel(
      id: 'q4',
      title: 'headache',
      text:
          'Ang pananakit ng ulo ay karaniwang kondisyon kung saan ang isang tao ay maaaring magkaroon ng banayad o masakit na pagpintig o masikip na sensasyon sa ulo.\nAng pananakit ng ulo na madalas mangyari ay tinatawag na migraine.Ang migraine na isang partikular na uri ng sakit ng ulo ay nararanasan bilang pumipintig na sakit sa isang bahagi ng ulo. Ito ay maaaring katamtaman hanggang malubhang sakit.',
      difficulty: QuestionDifficulty.lesson_1,
      video: 'assets/video_question/L1_headache.mp4',
      answersId: ['a1', 'a2'],
      choices: <AnswerModel>[
        const AnswerModel(
            id: 'a1',
            value: 'Paracatemol',
            image: 'assets/image_choices/medicine.png',
            explanation:
                'uminom ng 1000mg ng paracetamol para maiwasan angpagkasakit ng ulo.',
            video: 'assets/video_answer/L1_headache_1.mp4'),
        const AnswerModel(
            id: 'a2',
            value: 'Rest',
            image: 'assets/image_choices/rest.png',
            explanation:
                'magpahinga sa isang komportableng upuan upang makapag pagaan ng sakit ng ulo.',
            video: 'assets/video_answer/L1_headache_2.mp4'),
        const AnswerModel(
            id: 'a3',
            value: 'Betadine',
            image: 'assets/image_choices/betadine.png',
            explanation: '',
            video: ''),
        const AnswerModel(
            id: 'a4',
            value: 'Inhaler',
            image: 'assets/image_choices/inhaler.png',
            explanation: '',
            video: ''),
      ],
    ),
    QuestionModel(
      id: 'q5',
      title: 'chest pain',
      text:
          'Ang pananakit ng dibdib, kakulangan sa ginhawa, o presyon, ay maaaring magpahiwatig ng mahinang sirkulasyon kung saan sa puso ay hindi tumatanggap ng sapat na dugo o oxygen. Pananakit o paninikip ng dibdib as sintomas ng sakit sa puso can be described in several ways. ',
      difficulty: QuestionDifficulty.lesson_1,
      video: 'assets/video_question/L1_chestpain.mp4',
      answersId: ['a1', 'a2'],
      choices: <AnswerModel>[
        const AnswerModel(
            id: 'a1',
            value: 'Rest',
            image: 'assets/image_choices/rest.png',
            explanation:
                'humanap ng mauupuan upang makapagpahinga dito ang isang taong may masakit na dibdib.',
            video: 'assets/video_answer/L1_chestpain_1.mp4'),
        const AnswerModel(
            id: 'a2',
            value: 'Acetylsalicylic acid',
            image: 'assets/image_choices/acetylsalicylic.png',
            explanation:
                'uminom ng acetylsalicylic acid  Upang maiwasan ang atake sa puso o stroke na dulot ng makitid na daluyan ng dugo na nagiging barado.',
            video: 'assets/video_answer/L1_chestpain_2.mp4'),
        const AnswerModel(
            id: 'a3',
            value: 'Alcohol',
            image: 'assets/image_choices/alcohol.png',
            explanation: '',
            video: ''),
        const AnswerModel(
            id: 'a4',
            value: 'Hot Water',
            image: 'assets/image_choices/hot_water.png',
            explanation: '',
            video: ''),
      ],
    ),

    /// LESSON2

    QuestionModel(
      id: 'q6',
      title: 'blister',
      text:
          'Ang friction blister ay isang maliit na bulsa ng likido na nabubuo sa itaas na mga layer ng balat na dulot ng patuloy na pagkuskos o presyon sa paglipas ng panahon.\nKaraniwang lumilitaw ang friction blister sa mga paa habang naglalakad o pagkatapos ng malalayong lakarin.',
      difficulty: QuestionDifficulty.lesson_2,
      video: 'assets/video_question/L2_blister.mp4',
      answersId: ['a1', 'a2', 'a3', 'a4'],
      choices: <AnswerModel>[
        const AnswerModel(
            id: 'a1',
            value: 'Warm water',
            image: 'assets/image_choices/warm_water.png',
            explanation:
                'makakatulong ito upang maging malinis ang nasabing blister or paltos sa paa.',
            video: 'assets/video_answer/L2_blister_1.mp4'),
        const AnswerModel(
            id: 'a2',
            value: 'Needle',
            image: 'assets/image_choices/needle.png',
            explanation:
                'kinakailangan ng matilos na bagay dahil makaaktulong ito upang matanggal ang fluid sa loob ng paltos ng paa.',
            video: 'assets/video_answer/L2_blister_2.mp4'),
        const AnswerModel(
            id: 'a3',
            value: 'Bluster pad',
            image: 'assets/image_choices/blister_pad.png',
            explanation:
                'takpan ng blister pad dahil makakatulong ito upang gumaling ang sugat o blister',
            video: 'assets/video_answer/L2_blister_3.mp4'),
        const AnswerModel(
            id: 'a4',
            value: 'Ointment',
            image: 'assets/image_choices/ointment.png',
            explanation:
                'makakatulong ito upang mas mapadali ang paggamot nito.',
            video: 'assets/video_answer/L2_blister_4.mp4'),
      ],
    ),

    QuestionModel(
      id: 'q7',
      title: 'sore throat',
      text:
          'Ang namamagang lalamunan ay kapag ang isang tao ay may tuyo at magaspang na pananakit sa kanyang lalamunan kapag lumulunok. Ito ay maaaring sanhi ng ilang mga kondisyon kabilang ang isang viral o bacterial infection tulad ng sipon pati narin ang pakikipagusap ng malakas ang boses o ang pagsigaw.',
      difficulty: QuestionDifficulty.lesson_2,
      video: 'assets/video_question/L2_sorethroat.mp4',
      answersId: ['a1', 'a2', 'a3', 'a4'],
      choices: <AnswerModel>[
        const AnswerModel(
            id: 'a1',
            value: 'Medicine (Lozenges)',
            image: 'assets/image_choices/medicine.png',
            explanation:
                'uminom ng gamot na Lozenges upang mabawasan ang pagsakit ng lalamunan.',
            video: 'assets/video_answer/L2_sorethroat_1.mp4'),
        const AnswerModel(
            id: 'a2',
            value: 'Warm water',
            image: 'assets/image_choices/hot_water.png',
            explanation:
                'uminom ng maligamgam na tubig dahil makakatulong ito upang mawala ang pananakit.',
            video: 'assets/video_answer/L2_sorethroat_2.mp4'),
        const AnswerModel(
            id: 'a3',
            value: 'Mouth Spray',
            image: 'assets/image_choices/mouth_spray.png',
            explanation:
                'maaaring gumamit din ng mouthspray dahil  makakatulong ito upang maiwasan ang pananakit ng lalamunan.',
            video: 'assets/video_answer/L2_sorethroat_3.mp4'),
        const AnswerModel(
            id: 'a4',
            value: 'Rest',
            image: 'assets/image_choices/rest.png',
            explanation:
                'kinakailangan na ipahinga ang lalamunan upang maiwasan ang pagsakit ng lalamunan. ',
            video: 'assets/video_answer/L2_sorethroat_4.mp4'),
      ],
    ),

    QuestionModel(
      id: 'q8',
      title: 'back pain',
      text:
          'Ang lower back pain ay ang pananakit ng ibabang bahagi ng likod o ang tinatawag na lumbar spine.Ang mga pinsalang ito ay maaaring magresulta mula sa pagbubuhat ng mabibigat na bagay, stress o pinsala sa isang disc sa ating gulugod.',
      difficulty: QuestionDifficulty.lesson_2,
      video: 'assets/video_question/L2_backpain.mp4',
      answersId: ['a1', 'a2', 'a3', 'a4'],
      choices: <AnswerModel>[
        const AnswerModel(
            id: 'a1',
            value: 'Medicine (Ibuprofen)',
            image: 'assets/image_choices/medicine.png',
            explanation:
                ' ang paginom ng ibuprofen ay makakatulong upang mabawasan ang pagsakit ng likod.',
            video: 'assets/video_answer/L2_backpain_1.mp4'),
        const AnswerModel(
            id: 'a2',
            value: 'Water',
            image: 'assets/image_choices/warm_water.png',
            explanation:
                'uminom ng tubig upang mas lalong mapagaling ang pagsakit ng likod.',
            video: 'assets/video_answer/L2_backpain_2.mp4'),
        const AnswerModel(
            id: 'a3',
            value: 'Rest',
            image: 'assets/image_choices/rest.png',
            explanation:
                'kinakailangan na makapahinga upang maiwasan ang pananakit ng likod',
            video: 'assets/video_answer/L2_backpain_3.mp4'),
        const AnswerModel(
            id: 'a4',
            value: 'Heat Water Pad',
            image: 'assets/image_choices/heat_water_pad.png',
            explanation:
                'gumamit ng heat water pad para mabawasan at tuluyang mawala ang pananakit ng likod ',
            video: 'assets/video_answer/L2_backpain_4.mp4'),
      ],
    ),

    QuestionModel(
      id: 'q9',
      title: 'abdominal pain',
      text:
          'Ang pananakit ng tiyan o abdominal pain ay ang pananakit ng mga bahaging sakop ng tadyang hanggang balakang.Kung ang pananakit ng tiyan ay nagtagal lamang ng ilang oras o araw, ito ay matatawag na acute abdominal pain.',
      difficulty: QuestionDifficulty.lesson_2,
      video: 'assets/video_question/L2_abdominal_pain.mp4',
      answersId: ['a1', 'a2', 'a3', 'a4'],
      choices: <AnswerModel>[
        const AnswerModel(
            id: 'a1',
            value: 'Water',
            image: 'assets/image_choices/how_water.png',
            explanation:
                'uminom palagi ng isang basong tubig upang maiwasan ang pananakit ng tiyan.',
            video: 'assets/video_answer/L2_abdominal_pain_1.mp4'),
        const AnswerModel(
            id: 'a2',
            value: 'Walk',
            image: 'assets/image_choices/walk.png',
            explanation:
                'subukang lumakad lakad dahil makakatulong ito na makapagpawala ng sakit ng tyan.',
            video: 'assets/video_answer/L2_abdominal_pain_2.mp4'),
        const AnswerModel(
            id: 'a3',
            value: 'Lay down',
            image: 'assets/image_choices/laydown.png',
            explanation:
                'subukang humiga ng ilang minuto para mabawasan ang pananakit nito.',
            video: 'assets/video_answer/L2_abdominal_pain_3.mp4'),
        const AnswerModel(
            id: 'a4',
            value: 'Rest',
            image: 'assets/image_choices/rest.png',
            explanation:
                'At sa huli ay magpahinga dahil kinakailangan na makapahinga upang mas mawala ang pananakit.',
            video: 'assets/video_answer/L2_abdominal_pain_4.mp4'),
      ],
    ),

    //LESSON 3

    QuestionModel(
      id: 'q10',
      title: 'burn',
      text:
          'Ang burn o paso ay nangyayari kapag ang ating balat ay napadikit o nalagyan ng bagay na mainit. Ang burn ay nagdudulot ng pinsala sa ating balat o sa ilalim nito dahil sa sobrang init, kemikal. ',
      difficulty: QuestionDifficulty.lesson_3,
      video: 'assets/video_question/L3_burn.mp4',
      answersId: ['a1', 'a2', 'a3', 'a4'],
      choices: <AnswerModel>[
        const AnswerModel(
            id: 'a1',
            value: 'Water',
            image: 'assets/image_choices/faucet_water.png',
            explanation:
                'hugasan kaagad ang napasong kamay l nakakatulong ito na maiwasan ang pagkalala ng pagkapaso.',
            video: 'assets/video_answer/L3_burn_1.mp4'),
        const AnswerModel(
            id: 'a2',
            value: 'Antibacterial Soap',
            image: 'assets/image_choices/antibacterial_soap.png',
            explanation:
                'maaaring gumamit ng antibacterial soap upang maalis ang anumang bacterya na napunta sa pagkapaso.',
            video: 'assets/video_answer/L3_burn_2.mp4'),
        const AnswerModel(
            id: 'a3',
            value: 'Oinment',
            image: 'assets/image_choices/ointment.png',
            explanation:
                'ang paggamit ng ointment ay nakakapagpagaling ng isang paso upang mas hindi lumala ito. ',
            video: 'assets/video_answer/L3_burn_3.mp4'),
        const AnswerModel(
            id: 'a4',
            value: 'Bandage',
            image: 'assets/image_choices/bandage.png',
            explanation:
                'maaaring takpan ang napasong kamay upang maiwasan ang pagsakit nito at madumihan. ',
            video: 'assets/video_answer/L3_burn_4.mp4'),
        const AnswerModel(
            id: 'a5',
            value: 'Inhaler',
            image: 'assets/image_choices/inhaler.png',
            explanation: '',
            video: ''),
        const AnswerModel(
            id: 'a6',
            value: 'Needle',
            image: 'assets/image_choices/needle.png',
            explanation: '',
            video: ''),
      ],
    ),

    QuestionModel(
      id: 'q11',
      title: 'mamal bite',
      text:
          'Ang kagat ng aso ay isang kagat na sugat na dulot ng aso.Ang ilang mga aso ay tahol lamang pagkatapos ng kagat, habang ang ilan ay maaaring magpakita ng ilang pagsalakay bago mangyari.',
      difficulty: QuestionDifficulty.lesson_3,
      video: 'assets/video_question/L3_mamal_bite.mp4',
      answersId: ['a1', 'a2', 'a3', 'a4'],
      choices: <AnswerModel>[
        const AnswerModel(
            id: 'a1',
            value: 'Water',
            image: 'assets/image_choices/faucet_water.png',
            explanation: 'Hugasan kaagad ito sa tubig ng maigi.',
            video: 'assets/video_answer/L3_mamal_bite_1.mp4'),
        const AnswerModel(
            id: 'a2',
            value: 'Antibacterial Soap',
            image: 'assets/image_choices/antibacterial_soap.png',
            explanation: 'Sabunan ito para malinis ang sugat.',
            video: 'assets/video_answer/L3_mamal_bite_2.mp4'),
        const AnswerModel(
            id: 'a3',
            value: 'Alcohol',
            image: 'assets/image_choices/antibacterial_soap.png',
            explanation:
                'maglagay o magispray ng alcohol upang mawala agad ang mga bakterya.',
            video: 'assets/video_answer/L3_mamal_bite_3.mp4'),
        const AnswerModel(
            id: 'a4',
            value: 'Oinment',
            image: 'assets/image_choices/bite_ointment.png',
            explanation:
                'lagyan ito ng ointment dahil nakaktulong ito na makapagpagaling ng sugat. ',
            video: 'assets/video_answer/L3_mamal_bite_4.mp4'),
        const AnswerModel(
            id: 'a5',
            value: 'Walk',
            image: 'assets/image_choices/walk.png',
            explanation: '',
            video: ''),
        const AnswerModel(
            id: 'a6',
            value: 'Ice',
            image: 'assets/image_choices/ice.png',
            explanation: '',
            video: ''),
      ],
    ),

    QuestionModel(
      id: 'q12',
      title: 'fructure',
      text:
          'Ang sprain at Strains ay mga pinsala sa ligaments, tendons o muscle. Ang bali ay isang break, chip, o crack sa isang buto. Kapag ang buto na nagsasalubong sa isang kasukasuan ay wala sa normal nitong posisyon ito ay tinatawag na dislokasyon.',
      difficulty: QuestionDifficulty.lesson_3,
      video: 'assets/video_question/L3_fructure.mp4',
      answersId: ['a1', 'a2', 'a3', 'a4'],
      choices: <AnswerModel>[
        const AnswerModel(
            id: 'a1',
            value: 'Ice',
            image: 'assets/image_choices/ice.png',
            explanation:
                'gumamit ng yelo dahil ito ay makakapagpabawas ng pamamaga ng nabaling buto.',
            video: 'assets/video_answer/L3_fructure_1.mp4'),
        const AnswerModel(
            id: 'a2',
            value: 'Bandage',
            image: 'assets/image_choices/bandage.png',
            explanation:
                'importante na lagyan ng bandage upang maiwasan ang paggalaw nito.',
            video: 'assets/video_answer/L3_fructure_2.mp4'),
        const AnswerModel(
            id: 'a3',
            value: 'Medicine (Ibuprofen)',
            image: 'assets/image_choices/antibacterial_soap.png',
            explanation:
                'uminom ng antibiotic para mawala ang sakit na nararamdaman.',
            video: 'assets/video_answer/L3_fructure_3.mp4'),
        const AnswerModel(
            id: 'a4',
            value: 'Rest',
            image: 'assets/image_choices/rest.png',
            explanation:
                'magpahinga at huwag subukang gumalaw ng gumalaw upang hindi na lumala ang sakit.',
            video: 'assets/video_answer/L3_fructure_4.mp4'),
        const AnswerModel(
            id: 'a5',
            value: 'Alcohol',
            image: 'assets/image_choices/alcohol.png',
            explanation: '',
            video: ''),
        const AnswerModel(
            id: 'a6',
            value: 'Betadine',
            image: 'assets/image_choices/betadine.png',
            explanation: '',
            video: ''),
      ],
    ),
  ];
}
