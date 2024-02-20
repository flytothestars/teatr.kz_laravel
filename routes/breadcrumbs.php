<?php

// Home
Breadcrumbs::for('home', function ($trail) {
    $trail->push('Главная', route('afisha'));
});

// Search
Breadcrumbs::for('search', function ($trail) {
    $trail->parent('home');
    $trail->push('Поиск', route('search'));
});

// Profile
Breadcrumbs::for('profile', function ($trail) {
    $trail->parent('home');
    $trail->push('Мой аккаунт', route('profile'));
});

// Profile tickets
Breadcrumbs::for('profiletickets', function ($trail) {
    $trail->parent('profile');
    $trail->push('Мои билеты', route('tickets'));
});

// Venues
Breadcrumbs::for('theatres', function ($trail) {
    $trail->parent('home');
    $trail->push('Театры', route('venues'));
});

// Venue item
Breadcrumbs::for('venueitem', function ($trail, $venue) {
    $trail->parent('theatres');
    $trail->push($venue->title, route('venueitem', $venue->slug));
});

// Cast item
Breadcrumbs::for('cast', function ($trail, $cast) {
    $trail->parent('home');
    $trail->push($cast->name, route('cast', $cast->slug));
});

// News
Breadcrumbs::for('news', function ($trail) {
    $trail->parent('home');
    $trail->push('Новости', route('news'));
});

// News item
Breadcrumbs::for('newsitem', function ($trail, $news) {
    $trail->parent('news');
    $trail->push($news->title, route('newsitem', $news->slug));
});

// Partners
Breadcrumbs::for('partners', function ($trail) {
    $trail->parent('home');
    $trail->push('Партнеры', route('partners'));
});

// Reviews
Breadcrumbs::for('reviews', function ($trail) {
    $trail->parent('home');
    $trail->push('Рецензии', route('feedbacks'));
});

// Page
Breadcrumbs::for('page', function ($trail, $page) {
    $trail->parent('home');
    $trail->push($page->title, route('page', $page->slug));
});

// Password reset
Breadcrumbs::for('passwordreset', function ($trail) {
    $trail->parent('home');
    $trail->push('Сброс пароля', route('profile'));
});


