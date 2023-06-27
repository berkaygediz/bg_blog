import 'package:flutter/material.dart';

import 'article.dart';

void main() => runApp(const MaterialApp(home: HomePage()));

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        primarySwatch: Colors.blueGrey,
      ),
      title: 'BG Blog',
      home: const Article(),
    );
  }
}

class ArticlePage extends StatefulWidget {
  final ArticlePost article;

  const ArticlePage(this.article, {super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  @override
  Widget build(BuildContext context) {
    final article = widget.article;
    return Scaffold(
      appBar: AppBar(
        title: Text(article.title),
        backgroundColor: Colors.deepOrange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                article.title,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Writer: ${article.author}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              Text(
                'Date: ${article.date}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              Image.asset(
                article.picture,
                width: MediaQuery.of(context).size.width,
                height: 200,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 20),
              Text(
                article.text,
                style: const TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TopWritersPage extends StatefulWidget {
  final List<ArticlePost> articles;

  const TopWritersPage({Key? key, required this.articles}) : super(key: key);

  @override
  State<TopWritersPage> createState() => _TopWritersPageState();
}

class _TopWritersPageState extends State<TopWritersPage> {
  @override
  Widget build(BuildContext context) {
    final authorarticles = <String, int>{};
    for (var article in widget.articles) {
      final author = article.author;
      authorarticles[author] = (authorarticles[author] ?? 0) + 1;
    }
    final topWrittenAuthor = authorarticles.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Writers'),
        backgroundColor: Colors.red,
        foregroundColor: Colors.black,
      ),
      body: ListView.builder(
        itemCount: topWrittenAuthor.length,
        itemBuilder: (context, index) {
          final author = topWrittenAuthor[index].key;
          final articleCount = topWrittenAuthor[index].value;
          return ListTile(
            title: Text(author),
            subtitle: Text('Posted: $articleCount'),
          );
        },
      ),
    );
  }
}

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.info)),
            ],
          ),
          title: const Text(
            'About',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.redAccent,
        ),
        body: const TabBarView(
          children: <Widget>[
            SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 16),
                  Text(
                    "Coder: Berkay Gediz",
                    style: TextStyle(
                      color: Colors.purple,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          color: Colors.black,
                          offset: Offset(2, 2),
                          blurRadius: 2,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Article extends StatefulWidget {
  const Article({Key? key}) : super(key: key);

  @override
  State<Article> createState() => _ArticleState();
}

class _ArticleState extends State<Article> {
  final List<ArticlePost> articles = [
    ArticlePost(
      title: 'Flutter ile Mobil Uygulama Geliştirme',
      text:
          'Flutter, Google tarafından geliştirilen açık kaynaklı bir kullanıcı arayüzü (UI) geliştirme kitidir. Mobil uygulama geliştirme için kullanılan Flutter, tek bir kod tabanı üzerinde çalışan ve Android ve iOS gibi farklı platformlarda uyumlu uygulamalar oluşturmanızı sağlar. Dart programlama dilini kullanarak geliştirilen Flutter, hızlı, etkileyici ve güzel kullanıcı arayüzleri oluşturmanıza olanak tanır. Zengin widget koleksiyonu, hızlı derleme süreleri ve sıcak yeniden yükleme gibi özellikleri sayesinde hızlı bir geliştirme deneyimi sunar. Ayrıca, Flutterın esneklik sağlayan ve geliştirme süreçlerini hızlandıran zengin bir ekosistemi bulunmaktadır.',
      author: 'Berkay Gediz',
      picture: 'assets/flutter.jpg',
      date: '25.05.2023',
    ),
    ArticlePost(
      title: 'Python ile Veri Analizi',
      text:
          'Python, veri analizi için kullanılan popüler bir programlama dilidir. Pythonun zengin kütüphane ve araç ekosistemi, veri analizi süreçlerini kolaylaştırır. Pandas, NumPy ve Matplotlib gibi kütüphaneler, veri manipülasyonu, hesaplama ve görselleştirme gibi işlemleri destekler. Pythonun basit ve anlaşılır sözdizimi, veri analizi için hızlı ve verimli kod yazmayı sağlar. Veri çekme, temizleme, dönüştürme ve analiz etme gibi adımları kolayca gerçekleştirmek için Python kullanılır. Ayrıca, Pythonun genişletilebilirliği ve topluluk desteği, veri analizinde kullanılan diğer araçlarla entegrasyonu kolaylaştırır.',
      author: 'Bay Baybak',
      picture: 'assets/python.png',
      date: '25.05.2023',
    ),
    ArticlePost(
      title: 'C# ile Nesne Yönelimli Programlama',
      text:
          'C#, nesne yönelimli programlamaya odaklanan güçlü bir programlama dilidir. Nesne yönelimli programlama, programın nesnelerin bir araya gelerek işbirliği yaptığı bir yapıda organize edilmesini sağlar. C#, sınıf ve nesne kavramlarını kullanarak veri ve işlevselliği bir araya getirir. Miras, polimorfizm, soyutlama gibi nesne yönelimli programlama prensiplerini destekler. C#ın zengin kütüphane desteği, büyük ölçekli uygulamaların geliştirilmesini kolaylaştırır. C#ın Microsoft .NET platformuna entegrasyonu, çoklu platform desteği ve geniş bir geliştirici topluluğu bulunması da avantajları arasındadır. C#, genel olarak Windows uygulama geliştirme, web uygulamaları ve oyun geliştirme gibi çeşitli alanlarda kullanılır.',
      author: 'Bay Baybak',
      picture: 'assets/csharp.png',
      date: '25.05.2023',
    ),
    ArticlePost(
      title: 'Web Geliştirme için HTML Temelleri',
      text:
          'HTML (HyperText Markup Language), web sayfalarının oluşturulmasında kullanılan bir işaretleme dilidir. Temel olarak yapısı, etiketler aracılığıyla içerikleri belirlemek ve biçimlendirmek üzerine kuruludur. HTML, textlerin başlık, paragraf, liste gibi yapılarla düzenlenmesini sağlar. Ayrıca pictureler, bağlantılar ve tablolar gibi diğer medya ve içerikleri de eklemek için kullanılır. HTML, tarayıcılar tarafından yorumlanarak web sayfalarının görüntülenmesini sağlar. HTML5, daha gelişmiş özellikler ve etiketler ekleyerek web geliştirme deneyimini zenginleştirmiştir. Web geliştirme için HTML temellerini bilmek, web sayfalarının oluşturulması ve biçimlendirilmesi için temel bir adımdır.',
      author: 'Reya Jeton',
      picture: 'assets/html.jpg',
      date: '25.05.2023',
    ),
    ArticlePost(
      title: 'Java ile Nesne Tabanlı Programlama',
      text:
          'Java, nesne tabanlı bir programlama dilidir ve çeşitli platformlarda uygulama geliştirmek için kullanılır. Nesne tabanlı programlama, programları nesnelerin bir araya gelmesiyle tasarlamaya dayanan bir yaklaşımdır. Java, bu yaklaşımı kullanarak veri ve işlevleri bir arada tutan nesneler oluşturmayı sağlar. Bu sayede programlar daha modüler, esnek ve yeniden kullanılabilir hale gelir. Java, sınıflar, nesneler, kalıtım, polimorfizm gibi nesne tabanlı programlama kavramlarını destekler. Ayrıca, platform bağımsız bir şekilde çalışabilen Java Sanal Makinesi (JVM) üzerinde çalışır, bu da Java uygulamalarının farklı işletim sistemlerinde çalışabilmesini sağlar. Java ile nesne tabanlı programlama yapmak, kodun daha organize, sürdürülebilir ve genişletilebilir olmasını sağlar.',
      author: 'Bay Baybak',
      date: '25.05.2023',
      picture: 'assets/java.jpg',
    ),
    ArticlePost(
      title: 'CSS ile Web Tasarımı',
      text:
          'CSS (Cascading Style Sheets), web tasarımında kullanılan bir stil dilidir. HTML belgelerine stil ve düzen uygulamak için kullanılır. CSS, web sayfalarının görünümünü kontrol etmek için kullanılan bir dizi stil özelliği ve kurallar kümesini içerir. Bu özellikler, text biçimlendirme, renkler, arka planlar, kenarlıklar, boyutlar ve yerleşim gibi birçok tasarım öğesini kontrol etmeye olanak sağlar. CSS, HTML ile birlikte kullanılarak web sayfalarının görsel olarak çekici, düzenli ve tutarlı olmasını sağlar. Ayrıca, CSS sayesinde bir web sitesinin tasarımını kolayca değiştirmek ve güncellemek mümkündür. CSSin kullanımı, web tasarımında profesyonel ve etkileyici bir görünüm elde etmek için önemli bir beceridir.',
      author: 'Berkay Gediz',
      date: '25.05.2023',
      picture: 'assets/css.jpg',
    ),
    ArticlePost(
      title: 'JavaScript ile Front-end Geliştirme',
      text:
          'JavaScript, web tarayıcıları üzerinde çalışan bir programlama dilidir ve front-end geliştirme sürecinde önemli bir rol oynar. JavaScript, web sayfalarına dinamiklik, etkileşim ve işlevsellik kazandırmak için kullanılır. Kullanıcı etkileşimleri, form doğrulamaları, animasyonlar, veri işleme, API entegrasyonları gibi birçok front-end görevini yerine getirmek için JavaScript kullanılır. Bu sayede, kullanıcılarla etkileşimli ve dinamik web deneyimleri sağlanır. JavaScript, tarayıcılar tarafından desteklenir ve HTML ve CSS ile birlikte kullanılarak web sayfalarının tamamlayıcı bir parçası haline gelir. JavaScriptin esnek ve güçlü yapısı, modern web uygulamalarının geliştirilmesinde vazgeçilmez bir rol oynar. Front-end geliştirme sürecinde JavaScripti öğrenmek ve kullanmak, interaktif ve kullanıcı dostu web arayüzleri oluşturmak için önemli bir adımdır.',
      author: 'Berkay Gediz',
      date: '25.05.2023',
      picture: 'assets/javascript.jpg',
    ),
    ArticlePost(
      title: 'SQL Veritabanı Yönetimi',
      text:
          'SQL (Structured Query Language), ilişkisel veritabanı yönetim sistemlerinde (RDBMS) veri manipülasyonu, sorgulama ve veritabanı yönetimi için kullanılan bir programlama dilidir. SQL, veritabanlarına veri eklemek, veri güncellemek, veri silmek, verileri sorgulamak ve veriler arasında ilişkiler kurmak için kullanılır. SQL, basit ve anlaşılır bir syntaxa sahiptir ve kullanıcıların veritabanı üzerinde çeşitli işlemleri gerçekleştirmesine olanak tanır. SQL, standart bir dil olup birçok veritabanı yönetim sistemi tarafından desteklenir. Veritabanı yönetimi, verilerin etkin bir şekilde depolanması, organize edilmesi, güncellenmesi ve sorgulanmasını içerir. SQL kullanarak veritabanı yönetimi yapmak, veri bütünlüğünü sağlamak ve verileri etkili bir şekilde yönetmek için önemli bir beceridir.',
      author: 'Berkay Gediz',
      date: '25.05.2023',
      picture: 'assets/sqlserver.png',
    ),
    ArticlePost(
      title: 'Swift ile iOS Uygulama Geliştirme',
      text:
          'Swift, Appleın iOS, macOS, watchOS ve tvOS gibi platformlar için geliştirdiği modern bir programlama dilidir. iOS uygulama geliştirmek için özel olarak tasarlanmış olan Swift, güçlü, güvenli ve kolay kullanılabilir bir dil olarak öne çıkar. Swift, geniş bir standart kütüphaneyle birlikte gelir ve zengin bir dil yapısına sahiptir. Nesne yönelimli programlama prensiplerini destekler ve fonksiyonel programlama özelliklerini içerir. Swift, geliştiricilere hızlı ve verimli bir şekilde iOS uygulamaları oluşturma imkanı sağlar. Kolay anlaşılır ve okunabilir syntaxıyla da dikkat çeken Swift, geliştiricilere esneklik ve performans sağlayarak kullanıcı dostu uygulamaların geliştirilmesini destekler.',
      author: 'Omar Kart',
      date: '25.05.2023',
      picture: 'assets/swift.png',
    ),
    ArticlePost(
      title: 'Ruby ile Web Uygulama Geliştirme',
      text:
          'Ruby, dinamik, yüksek seviyeli ve kullanıcı dostu bir programlama dilidir. Özellikle web uygulama geliştirmek için tercih edilen Ruby, basit ve anlaşılır bir syntaxa sahiptir. Ruby on Rails (Rails olarak da bilinir) adı verilen bir web frameworküyle birlikte kullanıldığında hızlı ve etkili web uygulamaları oluşturulabilir. Rubynin odak noktası üretkenlik ve programcı mutluluğudur, bu nedenle kodun okunabilirliği ve yazma kolaylığı ön plandadır. Ruby, açık kaynak bir dil olup, geniş bir topluluğa ve zengin bir ekosisteme sahiptir. Ruby ile web uygulama geliştirme, hızlı prototipleme, esneklik ve zengin kütüphane desteği gibi avantajları beraberinde getirir.',
      author: 'Omar Kart',
      date: '25.05.2023',
      picture: 'assets/ruby.jpg',
    ),
    ArticlePost(
      title: 'PHP ile Dinamik Web Sayfaları',
      text:
          'PHP, sunucu tarafında çalışan ve özellikle dinamik web sayfaları oluşturmak için kullanılan bir programlama dilidir. Genellikle HTML içine gömülerek kullanılan PHP, kullanıcıların etkileşimli ve dinamik içerikler sunmasına olanak sağlar. Veritabanı işlemleri, form verilerinin işlenmesi, oturum yönetimi gibi web uygulamalarının temel gereksinimlerini kolayca karşılar. PHPnin açık kaynak olması ve geniş bir kullanıcı tabanına sahip olması, zengin bir kütüphane ve framework ekosistemi sunar. PHP, web geliştirme sürecinde hızlı ve esnek bir çözüm sunar, kolayca öğrenilebilir ve yaygın olarak kullanılan bir dildir. Dinamik web sayfaları oluşturma ihtiyacı olan geliştiriciler için PHP, güçlü bir seçenektir.',
      author: 'Omar Kart',
      date: '25.05.2023',
      picture: 'assets/php.png',
    ),
    ArticlePost(
      title: 'C++ ile Performanslı Programlama',
      text:
          'C++, yüksek performans gerektiren uygulamaların geliştirilmesinde sıklıkla kullanılan bir programlama dilidir. Düşük seviye kontrol imkanı sağlayan C++ın derlenmiş yapısı, hızlı ve etkili bir şekilde çalışmasını sağlar. C++ın sahip olduğu düşük seviye bellek yönetimi, verimli kaynak kullanımı ve optimize edilebilirlik özellikleri sayesinde, oyun geliştirme, grafik işleme, gömülü sistemler, veri analizi gibi performans gerektiren alanlarda tercih edilir. C++ın nesne yönelimli yapısı, kodun modüler ve yeniden kullanılabilir olmasını sağlar. Geniş bir kütüphane desteği ve açık kaynak topluluğu, C++ı güçlü bir performanslı programlama dili haline getirir.',
      author: 'Hun Boyan',
      date: '25.05.2023',
      picture: 'assets/cplusplus.png',
    ),
    ArticlePost(
      title: 'R ile Veri Analitiği',
      text:
          'R, istatistiksel veri analizi ve veri madenciliği için kullanılan bir programlama dilidir. Geniş bir istatistiksel ve grafiksel fonksiyon koleksiyonuna sahip olan R, veri analitiği projelerinde sıkça tercih edilir. Rnin açık kaynak olması ve geniş bir kullanıcı topluluğuna sahip olması, kullanıcıların birbirleriyle paylaşımda bulunmasını ve geliştirilmiş paketlerden faydalanmasını sağlar. R, veri setlerinin analizini gerçekleştirmek, istatistiksel modeller oluşturmak, veri görselleştirmeleri yapmak ve tahminlerde bulunmak gibi işlemleri kolaylıkla yapabilme yeteneğine sahiptir. R, veri bilimciler, istatistikçiler ve araştırmacılar tarafından yaygın olarak kullanılan bir araçtır ve veri odaklı karar verme süreçlerine önemli katkı sağlar.',
      author: 'Hun Boyan',
      date: '25.05.2023',
      picture: 'assets/rlang.png',
    ),
    ArticlePost(
      title: 'Go ile Paralel Programlama',
      text:
          'Go, paralel programlama için tasarlanmış bir programlama dilidir. Gonun paralel programlama yetenekleri, hafif iş parçacıkları (goroutines) ve kanallar (channels) kullanarak sağlanır. Goroutines, hafif ve verimli işlem birimleridir ve Go dilinde eşzamanlı çalışan çok sayıda goroutine oluşturulabilir. Kanallar ise goroutineler arasındaki iletişimi ve veri paylaşımını kolaylaştırır. Gonun paralel programlama modeli, articlelım geliştiricilere çoklu görevlerin eşzamanlı olarak yürütülmesini kolaylaştırır ve performansı artırır. Paralel programlama sayesinde, işlemlerin parçalara bölünüp farklı işlem birimlerinde eşzamanlı olarak çalıştırılmasıyla daha hızlı ve verimli uygulamalar geliştirilebilir. Gonun paralel programlama yetenekleri, özellikle ağ uygulamaları, web sunucuları, veritabanı işlemleri gibi yoğun işlem gerektiren uygulamalarda etkili bir şekilde kullanılabilir.',
      author: 'Reya Jeton',
      date: '25.05.2023',
      picture: 'assets/golang.png',
    ),
    ArticlePost(
      title: 'Ruby on Rails ile Web Geliştirme',
      text:
          'Ruby on Rails, Ruby programlama diline dayanan bir web uygulama çatısıdır. Rails, hızlı ve verimli web uygulamaları geliştirmek için bir dizi hazır bileşeni ve kütüphaneyi bir araya getirir. Railsin temel felsefesi, articlelım geliştirme sürecini hızlandırmak, tekrarı azaltmak ve en iyi uygulamalara dayalı bir geliştirme ortamı sağlamaktır. Railsin MVC (Model-View-Controller) mimarisi, uygulamanın veri tabanı modelini, kullanıcı arayüzünü ve iş mantığını ayrı bileşenlere bölerek daha iyi bir kod organizasyonu ve bakım kolaylığı sunar. Rails, otomatik kod üretimi, RESTful yapılar, güvenlik önlemleri ve geniş bir eklenti ve gem ekosistemi gibi özelliklerle web geliştirme sürecini kolaylaştırır. Ruby on Rails, hızlı prototip oluşturma, sürdürülebilirlik, ölçeklenebilirlik ve kolaylık gibi avantajlarıyla web uygulamaları geliştirmek isteyen geliştiriciler arasında popüler bir tercihtir.',
      author: 'Berkay Gediz',
      date: '25.05.2023',
      picture: 'assets/rubyonrails.jpg',
    ),
    ArticlePost(
      title: 'Swift ile Oyun Geliştirme',
      text:
          'Swift ile oyun geliştirme, Appleın iOS, macOS, watchOS ve tvOS platformlarında kullanılan Swift programlama dilini kullanarak mobil ve masaüstü oyunları geliştirmeyi ifade eder. Swift, hızlı, güçlü ve kullanıcı dostu bir dil olduğu için oyun geliştirme için tercih edilen bir seçenektir. Swiftin zengin kütüphaneleri ve oyun geliştirme için özel olarak tasarlanmış araçları, grafikler, fizik motorları, ses işleme ve kullanıcı etkileşimi gibi oyun geliştirme unsurlarını kolayca yönetmeyi sağlar. Swift ile oyun geliştirmek, oyun fikirlerini gerçeğe dönüştürmek, oyun mekaniği, grafikler, animasyonlar ve kullanıcı deneyimi gibi unsurları bir araya getirerek etkileyici oyunlar oluşturmayı sağlar. Swiftin hızlı performansı ve güncel özellikleri, oyun geliştiricilerine daha iyi kontrol ve esneklik sunar.',
      author: 'Berkay Gediz',
      date: '25.05.2023',
      picture: 'assets/swift.png',
    ),
    ArticlePost(
      title: 'JavaScript ile ReactJS Kütüphanesi',
      text:
          'JavaScript ile ReactJS, web uygulamaları geliştirmek için kullanılan popüler bir JavaScript kütüphanesidir. ReactJS, kullanıcı arayüzlerini oluşturmak ve yönetmek için bileşen tabanlı bir yaklaşım sunar. Bu sayede karmaşık uygulamaları modüler parçalara ayırarak daha kolay bir şekilde geliştirmeyi sağlar. ReactJS, bileşenler arasındaki veri akışını etkin bir şekilde yönetir ve sanal DOM (Document Object Model) kullanarak performansı optimize eder. ReactJS, bileşenlerin yeniden kullanılabilirliğini ve uygulamanın ölçeklenebilirliğini artırır. Ayrıca, ReactJSin geniş bir ekosistemi vardır ve diğer kütüphaneler ve araçlarla kolayca entegre olabilir. JavaScript ile ReactJS kullanarak, hızlı, etkileşimli ve kullanıcı dostu web uygulamaları geliştirmek mümkündür.',
      author: 'Berkay Gediz',
      date: '25.05.2023',
      picture: 'assets/javascript.jpg',
    ),
    ArticlePost(
      title: 'PHP ile E-ticaret Sitesi Geliştirme',
      text:
          'PHP ile E-ticaret sitesi geliştirme, PHP programlama dilini kullanarak online alışveriş yapılabilen bir web sitesi oluşturma sürecidir. E-ticaret siteleri, kullanıcıların ürünleri keşfedebileceği, sepete ekleyebileceği, ödeme yapabileceği ve siparişleri yönetebileceği bir platform sağlar. PHPnin güçlü veritabanı entegrasyonu ve dinamik içerik oluşturma yetenekleri, e-ticaret sitelerinin ürünlerin listelenmesi, filtrelenmesi, stok yönetimi, kullanıcı hesapları ve ödeme işlemleri gibi önemli özelliklerini destekler. PHP tabanlı e-ticaret siteleri genellikle popüler açık kaynaklı platformlar ve çerçeveler kullanılarak geliştirilir, böylece hızlı bir başlangıç yapmak ve özelleştirme yapmak daha kolaydır. PHPnin esnekliği ve geniş topluluğu, güvenli, ölçeklenebilir ve kullanıcı dostu bir e-ticaret sitesi oluşturma sürecini destekler.',
      author: 'Yose Sul',
      date: '25.05.2023',
      picture: 'assets/php.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BG Blog'),
        backgroundColor: Colors.red,
        foregroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.select_all),
            onPressed: () {
              final snackBar = SnackBar(
                content: Text('Total Articles: ${articles.length}'),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
          ),
          IconButton(
            icon: const Icon(Icons.supervisor_account),
            onPressed: () {
              final authorinarticlesi =
                  articles.where((article) => article.author == 'Berkay Gediz');
              final snackBar = SnackBar(
                content: Text(
                    'Number of Articles by Berkay Gediz: ${authorinarticlesi.length}'),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: articles.length,
        itemBuilder: (context, index) {
          final article = articles[index];
          return ListTile(
            leading: Hero(
              tag: article.picture,
              child: CircleAvatar(
                backgroundImage: Image.asset(article.picture).image,
              ),
            ),
            trailing: const Icon(Icons.read_more_rounded),
            title: Text(articles[index].title),
            subtitle: Text(
              "${articles[index].author} - ${articles[index].date}\n${articles[index].text.substring(0, 50)}...",
              style: const TextStyle(color: Colors.grey),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ArticlePage(article),
                ),
              );
            },
          );
        },
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.red,
                image: DecorationImage(
                  image: AssetImage('assets/bglogo.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Text('BG Blog'),
            ),
            ListTile(
              title: const Text('Articles'),
              trailing: const Icon(Icons.arrow_forward_ios_rounded),
              leading: const Icon(Icons.text_snippet),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Top Writers'),
              trailing: const Icon(Icons.arrow_forward_ios_rounded),
              leading: const Icon(Icons.leaderboard),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TopWritersPage(articles: articles),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('About'),
              leading: const Icon(Icons.info_outline),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
