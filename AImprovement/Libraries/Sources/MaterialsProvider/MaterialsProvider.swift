import Foundation
import Types

public protocol MaterialsProvider {
    func getMaterials() -> [Types.Material]
}

public final class MaterialsProviderImpl: MaterialsProvider {
    
    public init() {
        
    }

    public func getMaterials() -> [Types.Material] {
        return materials
    }

    public func updateMaterial(id: Types.Material.ID) {
        materials[id].isLiked.toggle()
    }

    private var materials: [Types.Material] = [
        Types.Material(id: 0, author: "Даниэль Канеман", title: "Думай медленно, решай быстро", description: "Ещё один полезный текст для тех, кто хочет научиться управлять своим мышлением, чтобы быстрее и эффективнее принимать решения. Психолог, нобелевский лауреат и один из основоположников поведенческой экономики Даниэль Канеман рассказывает, чем «медленное» мышление отличается от «быстрого», и почему первое лучше второго в том, что касается принятия осознанных и рациональных решений.", icon: .book, isLiked: false, rating: 4.8, ratingCount: "2 отзыва"),
        Types.Material(id: 1, author: "Skillbox", title: "Менеджер проектов", description: "Менеджер проектов нужен всем компаниям. Он отвечает за проект от переговоров с заказчикам до его запуска на рынок, учитывая ресурсы компании и команды.", icon: .course, isLiked: false, rating: 4.5, ratingCount: "8 отзывов"),
        Types.Material(id: 2, author: "Skillbox", title: "Профессия Бизнес-аналитик", description: "Бизнес-аналитик помогает компаниям расти. Он детально изучает процессы, финансы и продукты бизнеса. А потом находит эффективные решения для развития и увеличения прибыли. Аналитики работают в разных сферах: от IT до финансов.", icon: .course, isLiked: false, rating: 4.7, ratingCount: "5 отзывов"),
        Types.Material(id: 3, author: "Skillbox", title: "Профессия Продакт-менеджер", description: "Продакт-менеджер востребован в любом бизнесе. Он делает продукты, которые полюбят пользователи. Для этого он контролирует их разработку, запуск и развитие.", icon: .course, isLiked: false, rating: 4.7, ratingCount: "9 отзывов"),
        Types.Material(id: 4, author: "Skillbox", title: "Эффективный руководитель", description: "Эффективный руководитель принимает управленческие решения, выстраивает бизнес-стратегию, устанавливает критерии эффективности работы команды и следит за их выполнением. Руководители отделов выстраивают операционные бизнес-процессы, поэтому существование любой компании без них невозможно.", icon: .course, isLiked: false, rating: 4.6, ratingCount: "3 отзыва"),
        Types.Material(id: 5, author: "Skillbox", title: "Soft Skills for Hard Times", description: "Вы научитесь управлять командами, распознавать эмоции коллег и выступать на публике. Узнаете, как не терять продуктивность в стрессовых ситуациях, лучше справляться с работой и чувствовать себя увереннее.", icon: .course, isLiked: false, rating: 4.5, ratingCount: "2 отзыва"),
        Types.Material(id: 6, author: "Дэвид Гоулман", title: "Эмоциональный интеллект", description: "Эта книга просто необходима, если ты хочешь продуктивно взаимодействовать с коллегами, гармонично существовать в коллективе и выстраивать прочные профессиональные отношения. Эта книга расскажет тебе о том, откуда берутся эмоции, зачем они нужны, научит управлять своим эмоциональным состоянием в любых ситуациях.", icon: .book, isLiked: false, rating: 4.8, ratingCount: "13 отзывов"),
        Types.Material(id: 7, author: "Кэрол Флеминг", title: "Говорить легко", description: "Если ты испытываешь сложности с тем, чтобы вести непринужденную беседу с малознакомым или совсем незнакомым человеком, если ты не знаешь, как плавно перевести легкий разговор в деловое русло, то тебе точно нужно ее прочесть.", icon: .book, isLiked: false, rating: 4.6, ratingCount: "9 отзывов"),
        Types.Material(id: 8, author: "Лора Стэк", title: "Вместе быстрее", description: "В этой книге ты найдешь описание 12-ти принципов командной работы. Книга расскажет тебе о том, что необходимо команде, чтобы быть эффективной. В этой книге много примеров плохой и хорошей командной работы, и автор объясняет почему так происходит.", icon: .book, isLiked: false, rating: 4.7, ratingCount: "5 отзывов"),
        Types.Material(id: 9, author: "Дэн Кеннеди", title: "Жёсткий менеджмент", description: "Дэн Кеннеди — стратегический маркетолог и автор, известный своим прямолинейным подходом к бизнесу и подаче материала. Опираясь на истории таких управленцев, как Джеф Безос, Стив Джобс и Уолт Дисней, Кеннеди предлагает рабочие стратегии в отношениях между руководителем и подчинёнными. Он призывает отказаться от традиционных методов, излагаемых в учебниках по менеджменту, и вернуть честность, прямоту и здоровый эгоизм в рабочий коллектив.", icon: .book, isLiked: false, rating: 4.9, ratingCount: "7 отзывов"),
        Types.Material(id: 10, author: "Leil Lowndes", title: "How to Talk to Anyone", description: "Продолжаем изучать мастерство общения — на этот раз вместе с экспертом в области психологии общения Лейл Лаундес. В книге она предлагает 92 приёма по налаживанию и укреплению отношений. Среди них — использование языка тела, ключевые слова и фразы для использования в беседе, советы по аргументации и многое другое.", icon: .book, isLiked: false, rating: 4.4, ratingCount: "3 отзыва"),
        Types.Material(id: 11, author: "Steven A. Cohen", title: "Sustainability management", description: "Устойчивое развитие — тема, которая волнует многих: от активистов до предпринимателей и глав государств. И не зря, ведь от приверженности компаний и политиков принципам устойчивого развития в прямом смысле зависит будущее планеты. В книге аналитик Стивен Коэн показывает: развивать экономику без вреда для окружающей среды — возможно. Признавая политические, финансовые и управленческие сложности такого проекта, он на конкретных примерах показывает, что всё — от строек до переработки мусора — может быть устроено экологичным образом.", icon: .book, isLiked: false, rating: 4.8, ratingCount: "6 отзывов")
    ]
}
