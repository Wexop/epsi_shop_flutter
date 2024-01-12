import 'package:epsi_shop/bo/article.dart';
import 'package:epsi_shop/page/about_us_page.dart';
import 'package:epsi_shop/page/article_detail.dart';
import 'package:epsi_shop/page/cart_page.dart';
import 'package:epsi_shop/page/home_page.dart';
import 'package:epsi_shop/page/payement_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
  }
}

/// The route configuration.
final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return HomePage();
      },
      routes: <RouteBase>[
        GoRoute(
            path: 'cart',
            builder: (_, __) {
              return CartPage();
            },
            routes: [
              GoRoute(
                  path: 'payement',
                  builder: (_, __) {
                    return PayementPage();
                  }),
            ]),
        GoRoute(
            path: 'aboutus',
            builder: (_, __) {
              return AboutUsPage();
            }),
        GoRoute(
          path: 'detail',
          builder: (_, GoRouterState state) {
            return ArticleDetailPage(
              article: state.extra as Article,
            );
          },
        )
      ],
    ),
  ],
);
