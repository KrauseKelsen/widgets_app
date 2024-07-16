import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class InfiniteScrollScreen extends StatefulWidget {
  static const String name = 'infinite_screen';

  const InfiniteScrollScreen({super.key});

  @override
  State<InfiniteScrollScreen> createState() => _InfiniteScrollScreenState();
}

class _InfiniteScrollScreenState extends State<InfiniteScrollScreen> {
  List<int> imagesIds = [1, 2, 3, 4, 5];
  final ScrollController scrollController =
      ScrollController(); // el builder con el scroll controler necesita de un init y un dispose
  bool isLoading = false;
  bool isMounted = true;

  @override
  void initState() {
    super.initState();
    //cuando es llamado el refresh el scrollcontroller se inicia y escucha si la posición actual+100 es mayor al maximo scroll
    scrollController.addListener(() {
      // cuando el scroll llega a su limite, le damos 500 pixeles de gracia antes para cargar mas imagenes a tiempo
      if ((scrollController.position.pixels + 500) >=
          scrollController.position.maxScrollExtent) {
        loadNextPages(); // de ser mayor recarga el scroll
      }
    });
  }

  Future loadNextPages() async {
    if (isLoading) return;
    isLoading = true;

    //si la lista no esta cargada toma dos segundos para recargar el bloque nuevo
    await Future.delayed(const Duration(seconds: 2));
    addFiveImages();
    isLoading = false;
    setState(() {});

    if (!isMounted) {
      return; // si el scroll esta montado no lo vuelve a cargar en el setState
    }

    setState(() {});
    moveScrollToBottom();
  }

  void moveScrollToBottom() {
    //cuando esta cerca del final de la pantalla se dispara esta funcion
    if (scrollController.position.pixels + 100 <=
        scrollController.position.maxScrollExtent) {
      return;
    } //no hace nada si el scroll no esta cerca del final

    //si esta cerca del final entonces realiza esta animacion
    scrollController.animateTo(scrollController.position.pixels + 120,
        duration: const Duration(milliseconds: 300),
        curve: Curves.fastOutSlowIn);
  }

  void addFiveImages() {
    // Toma el ultimo image y agrega una posicion para continuar el scroll
    final int lastId = imagesIds.last;
    imagesIds.addAll(
        // se agrega un bloque mas del mismo size a la variable imagesIds
        [1, 2, 3, 4, 5].map((value) => lastId + value));
  }

  @override
  void dispose() {
    scrollController.dispose(); //limpia el scrollcontroller
    isMounted =
        false; // el usuario destruye el scroll por lo que dejan de estar montadas las imagenes
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // remueve el padding que tienen los dispositivos en pantalla para hacer un screen full
      body: MediaQuery.removePadding(
        context: context,
        removeBottom: true,
        child: RefreshIndicator(
          onRefresh: () async {
            isLoading = true;
            await Future.delayed(const Duration(seconds: 3));
            if (!isMounted) {
              return;
            } //si despues de 3 seg no se ha cargado todo debera cargarlo

            isLoading = false;
            final lastId = imagesIds.last;
            imagesIds.clear(); // con el setStates borrara todos las imagenes
            imagesIds.add(lastId + 1);
            addFiveImages();
            setState(() {});
          },
          child: ListView.builder(
              controller: scrollController,
              itemCount: imagesIds.length,
              itemBuilder: (context, index) {
                NetworkImage image = NetworkImage(
                    'https://picsum.photos/id/${imagesIds[index]}/640/640');
                return Column(
                  children: [
                    appBarFeed(image),
                    bodyFeed(image),
                    footerFeed(),
                    commentFeed(image),
                  ],
                );
              }),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (isLoading) return;
          context.pop();
        },
        // si esta cargando el boton cambia de refresh a allow back
        child: (isLoading)
            ? FadeIn(
                child: SpinPerfect(
                    infinite: true, child: const Icon(Icons.refresh_rounded)),
              )
            : FadeIn(
                child: const Icon(Icons.arrow_back_ios_new_outlined),
              ), // FadeIn: transition to change of icon
      ),
    );
  }

  Widget appBarFeed(NetworkImage image) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 8.0, 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                height: 40.0,
                width: 40.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(fit: BoxFit.fill, image: image),
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              const Text(
                'Hola Kelssen',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const IconButton(
            style:
                ButtonStyle(iconColor: MaterialStatePropertyAll(Colors.black)),
            icon: Icon(Icons.more_vert),
            onPressed: null,
          )
        ],
      ),
    );
  }

  Widget bodyFeed(NetworkImage image) {
    return FadeInImage(
        fit: BoxFit.cover,
        width: double.infinity,
        placeholder: const AssetImage('assets/images/jar-loading.gif'),
        image: image);
  }

  Widget footerFeed() {
    return const Padding(
      padding: EdgeInsets.fromLTRB(16.0, 16.0, 8.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(FontAwesomeIcons.heart),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(FontAwesomeIcons.comment),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(FontAwesomeIcons.paperPlane)
                ],
              ),
              Icon(FontAwesomeIcons.bookmark)
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            'Liked by Yor Forger and 5844,522 others',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget commentFeed(NetworkImage image) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 8.0, 8.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 40.0,
              width: 40.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(fit: BoxFit.fill, image: image),
              ),
            ),
            const SizedBox(
              width: 10.0,
            ),
            const Expanded(
              child: TextField(
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: "Add a comment..."),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 5.0,
        ),
        const Text(
          "20 Minutes Ago",
          style: TextStyle(color: Colors.grey),
        ),
      ]),
    );
  }
}
