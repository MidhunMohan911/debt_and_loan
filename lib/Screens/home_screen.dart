import 'package:debt_and_loan/Model/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Constant/const_colors.dart';
import '../Controller/cubit/posts_cubit.dart';
import 'widgets/card_widget.dart';
import 'widgets/rounded_header.dart';

class PostsView extends StatefulWidget {
  @override
  State<PostsView> createState() => _PostsViewState();
}

class _PostsViewState extends State<PostsView> {
  final scrollController = ScrollController();

  @override
  void initState() {
    BlocProvider.of<PostsCubit>(context).loadPosts();

    scrollController.addListener(() {
      int page = BlocProvider.of<PostsCubit>(context).page;

      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        if (page <= 6) {
          BlocProvider.of<PostsCubit>(context).loadPosts();
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidht = MediaQuery.of(context).size.width;

    return Scaffold(
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverAppBar(
            backgroundColor: ConstColors().gradientEnd,
            leading: const Padding(
              padding: EdgeInsets.only(left: 10),
              child: CircleAvatar(
                backgroundImage: AssetImage(
                    'assets/Images/Screenshot_2022-06-24-00-45-05-414_com.instagram.android.jpg'),
              ),
            ),
            title: const Text(
              'Home',
              style: TextStyle(color: Colors.black),
            ),
            centerTitle: true,
            actions: const [
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: Icon(
                  Icons.notifications,
                  color: Colors.black,
                ),
              )
            ],
            bottom: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              titleSpacing: 0,
              toolbarHeight: mHeight * .16,
              title: Column(
                children: [
                  Stack(
                    children: [
                      Positioned(
                        top: 30,
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                            color: Colors.white,
                          ),
                          height: mHeight * .3,
                          width: mWidht * 1,
                        ),
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: const [
                              RoundedHeaderWidget(
                                icon: 'assets/Images/plus.png',
                                title: 'NEW',
                              ),
                              RoundedHeaderWidget(
                                icon: 'assets/Images/topright-arrow.png',
                                title: 'PAY OFF',
                              ),
                              RoundedHeaderWidget(
                                icon: 'assets/Images/bottomleft_arrow.png',
                                title: 'LEND',
                              ),
                              RoundedHeaderWidget(
                                icon: 'assets/Images/grid.png',
                                title: 'MORE',
                              ),
                            ],
                          ),
                          buildMyDebtsHeading(),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            elevation: 0,
            expandedHeight: mHeight * .44,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: ConstColors().gradientStart,
                child: Column(
                  children: [
                    SizedBox(height: mHeight * .15),
                    SizedBox(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(width: mWidht * .07),
                          CardWidget(
                              title: 'Owe me',
                              amount: "\$ 1250",
                              image: 'assets/Images/bottom_left_arrow.png',
                              color: ConstColors().tileGreen),
                          CardWidget(
                              title: 'I Owe',
                              amount: "\$ 1130",
                              image: 'assets/Images/top_right_arrow.png',
                              color: ConstColors().tileOrange),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              collapseMode: CollapseMode.pin,
            ),
          ),
          buildListTile()
        ],
      ),
      bottomNavigationBar: buildBottomNavBar(),
    );
  }

  BottomNavigationBar buildBottomNavBar() {
    return BottomNavigationBar(
      selectedItemColor: Colors.black,
      selectedLabelStyle: const TextStyle(color: Colors.black),
      type: BottomNavigationBarType.fixed,
      items: [
        const BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        const BottomNavigationBarItem(icon: Icon(Icons.list), label: 'History'),
        const BottomNavigationBarItem(
            icon: Icon(Icons.lightbulb_outline), label: 'Articles'),
        BottomNavigationBarItem(
          icon: ElevatedButton(
            style: ButtonStyle(
                shape: MaterialStateProperty.all(const StadiumBorder()),
                backgroundColor:
                    MaterialStateProperty.all(ConstColors().yellow)),
            onPressed: () {},
            child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 17,horizontal: 10),
                child: Icon(
                  Icons.add,
                  size: 27,
                  color: Colors.black,
                )),
          ),
          label: '',
        ),
      ],
    );
  }

  Widget buildListTile() {
    return SliverToBoxAdapter(
      child: BlocBuilder<PostsCubit, PostsState>(builder: (context, state) {
        if (state is PostsLoading && state.isFirstFetch) {
          return _loadingIndicator();
        }

        List<ClientDetails> posts = [];
        bool isLoading = false;

        if (state is PostsLoading) {
          posts = state.oldPosts;
          isLoading = true;
        } else if (state is PostsLoaded) {
          posts = state.posts;
        }

        return ListView.builder(
          primary: false,
          shrinkWrap: true,
          itemCount: posts.length + (isLoading ? 1 : 0),
          itemBuilder: (context, index) {
            if (index < posts.length) {
              var data = posts[index];
              return Card(
                elevation: 0.8,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(data.img!),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    title: Text(data.name!),
                    subtitle: Text("Until ${data.until!}"),
                    trailing: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const SizedBox(height: 4),
                        Text(
                          data.amount!,
                          style: TextStyle(color: ConstColors().tileOrange,fontSize: 17),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          data.outOfAmount!,
                          style: const TextStyle(
                              fontSize: 13, color: Colors.black38),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }
            return _loadingIndicator();
          },
        );
      }),
    );
  }

  Padding buildMyDebtsHeading() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'My debts',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            Text(
              'See All',
              style: TextStyle(color: ConstColors().tileHalfGrey, fontSize: 19),
            )
          ],
        ),
      ),
    );
  }

  Widget _loadingIndicator() {
    // return Shimmer.fromColors(
    //   baseColor: Colors.grey,
    //   highlightColor: Colors.grey.shade100,
    //   enabled: true,
    //   child: Padding(
    //     padding: const EdgeInsets.all(8.0),
    //     child: Column(
    //       children: List.generate(
    //         6,
    //         (index) => const LoadingWidget(),
    //       ),
    //     ),
    //   ),
    // );

    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
