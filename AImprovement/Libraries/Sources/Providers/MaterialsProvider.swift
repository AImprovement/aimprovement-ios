import Foundation
import Types

public protocol MaterialsProvider {
    func getMaterials() -> [Types.Material]
}

public final class MaterialsProviderImpl: MaterialsProvider {
    public init() { }
    public func getMaterials() -> [Types.Material] {
        return materials
    }

    public func updateMaterial(id: Types.Material.ID) {
        materials[id].isLiked.toggle()
    }

    private var materials: [Types.Material] = [
        Types.Material(id: 0, author: "Даниэль Канеман", title: "Думай медленно, решай быстро", description: "Ещё один полезный текст для тех, кто хочет научиться управлять своим мышлением, чтобы быстрее и эффективнее принимать решения. Психолог, нобелевский лауреат и один из основоположников поведенческой экономики Даниэль Канеман рассказывает, чем «медленное» мышление отличается от «быстрого», и почему первое лучше второго в том, что касается принятия осознанных и рациональных решений.", icon: .book, isLiked: false, rating: 4.5, ratingCount: "2 отзыва", link: URL(string: "https://www.litres.ru/book/daniel-kaneman/dumay-medlenno-reshay-bystro-6444517/chitat-onlayn/")!, price: "399₽", site: "Литрес"),

        Types.Material(id: 1, author: "Skillbox", title: "Менеджер проектов", description: "Менеджер проектов нужен всем компаниям. Он отвечает за проект от переговоров с заказчикам до его запуска на рынок, учитывая ресурсы компании и команды.", icon: .course, isLiked: false, rating: 4.5, ratingCount: "8 отзывов", link: URL(string: "https://skillbox.ru/course/profession-project-manager-pro/")!, price: "6720₽", site: "Skillbox"),

        Types.Material(id: 2, author: "Skillbox", title: "Профессия Бизнес-аналитик", description: "Бизнес-аналитик помогает компаниям расти. Он детально изучает процессы, финансы и продукты бизнеса. А потом находит эффективные решения для развития и увеличения прибыли. Аналитики работают в разных сферах: от IT до финансов.", icon: .course, isLiked: false, rating: 4.7, ratingCount: "5 отзывов", link: URL(string: "https://skillbox.ru/course/profession-business-analyst/")!, price: "4577₽", site: "Skillbox"),

        Types.Material(id: 3, author: "Skillbox", title: "Профессия Продакт-менеджер", description: "Продакт-менеджер востребован в любом бизнесе. Он делает продукты, которые полюбят пользователи. Для этого он контролирует их разработку, запуск и развитие.", icon: .course, isLiked: false, rating: 4.7, ratingCount: "9 отзывов", link: URL(string: "https://skillbox.ru/course/profession-product-manager-pro-test/")!, price: "4769₽", site: "Skillbox"),

        Types.Material(id: 4, author: "Skillbox", title: "Эффективный руководитель", description: "Эффективный руководитель принимает управленческие решения, выстраивает бизнес-стратегию, устанавливает критерии эффективности работы команды и следит за их выполнением. Руководители отделов выстраивают операционные бизнес-процессы, поэтому существование любой компании без них невозможно.", icon: .course, isLiked: false, rating: 4.6, ratingCount: "3 отзыва", link: URL(string: "https://skillbox.ru/course/head/")!, price: "4249₽", site: "Skillbox"),

        Types.Material(id: 5, author: "Skillbox", title: "Soft Skills for Hard Times", description: "Вы научитесь управлять командами, распознавать эмоции коллег и выступать на публике. Узнаете, как не терять продуктивность в стрессовых ситуациях, лучше справляться с работой и чувствовать себя увереннее.", icon: .course, isLiked: false, rating: 4.5, ratingCount: "2 отзыва", link: URL(string: "https://skillbox.ru/course/soft-skills-for-hard-times/")!, price: "3644₽", site: "Skillbox"),

        Types.Material(id: 6, author: "Дэвид Гоулман", title: "Эмоциональный интеллект", description: "Эта книга просто необходима, если ты хочешь продуктивно взаимодействовать с коллегами, гармонично существовать в коллективе и выстраивать прочные профессиональные отношения. Эта книга расскажет тебе о том, откуда берутся эмоции, зачем они нужны, научит управлять своим эмоциональным состоянием в любых ситуациях.", icon: .book, isLiked: false, rating: 4.8, ratingCount: "13 отзывов", link: URL(string: "https://www.litres.ru/book/deniel-goulman/emocionalnyy-intellekt-pochemu-on-mozhet-znachit-bolshe-che-5024477/")!, price: "499₽", site: "Литрес"),

        Types.Material(id: 7, author: "Лора Стэк", title: "Вместе быстрее", description: "В этой книге ты найдешь описание 12-ти принципов командной работы. Книга расскажет тебе о том, что необходимо команде, чтобы быть эффективной. В этой книге много примеров плохой и хорошей командной работы, и автор объясняет почему так происходит.", icon: .book, isLiked: false, rating: 4.7, ratingCount: "5 отзывов", link: URL(string: "https://www.litres.ru/book/lora-stek-15902078/vmeste-bystree-34930028/")!, price: "449₽", site: "Литрес"),

        Types.Material(id: 8, author: "Дэн Кеннеди", title: "Жёсткий менеджмент", description: "Дэн Кеннеди — стратегический маркетолог и автор, известный своим прямолинейным подходом к бизнесу и подаче материала. Опираясь на истории таких управленцев, как Джеф Безос, Стив Джобс и Уолт Дисней, Кеннеди предлагает рабочие стратегии в отношениях между руководителем и подчинёнными. Он призывает отказаться от традиционных методов, излагаемых в учебниках по менеджменту, и вернуть честность, прямоту и здоровый эгоизм в рабочий коллектив.", icon: .book, isLiked: false, rating: 4.9, ratingCount: "7 отзывов", link: URL(string: "https://www.litres.ru/book/den-kennedi/zhestkiy-menedzhment-6741142/chitat-onlayn/")!, price: "549₽", site: "Литрес"),

        Types.Material(id: 9, author: "Leil Lowndes", title: "How to Talk to Anyone", description: "Продолжаем изучать мастерство общения — на этот раз вместе с экспертом в области психологии общения Лейл Лаундес. В книге она предлагает 92 приёма по налаживанию и укреплению отношений. Среди них — использование языка тела, ключевые слова и фразы для использования в беседе, советы по аргументации и многое другое.", icon: .book, isLiked: false, rating: 4.4, ratingCount: "3 отзыва", link: URL(string: "https://www.litres.ru/book/leil-lowndes/how-to-talk-to-anyone-92-little-tricks-for-big-success-in-rel-39753041/")!, price: "669₽", site: "Литрес"),

    ]
}
