<section class="section__homeevents">
    <div class="container mob-container">
        <h1>Афиша и билеты в театры {{ $city->title }}</h1>
        <div  id="vue-filtered-events">
            <div v-cloak>
                <div class="d-md-flex d-block home__filter_menu justify-content-start mb-4 mt-4">
                    <a class="filter-a"
                       v-for="(f, find) in timefilters"
                       :class="{ active: selected.time == f.id }"
                       @click="filterClicked(f)"
                       :key="`filter-${find}`">
                        @{{ f.title }}
                    </a>
                    <div class="select-wrapper">
                        <select v-model="selected.venue" class="filter-a">
                            <option :value="null">-</option>
                            <option v-for="(v, vind) in venues" :value="v.id" :key="`venue-op-${vind}`">@{{ transName(v.title) }}</option>
                        </select>
                    </div>
                    <div class="select-wrapper">
                        <select v-model="selected.genre" class="filter-a">
                            <option :value="null">-</option>
                            <option v-for="(g, gind) in genres" :value="g.id" :key="`genre-op-${gind}`">@{{ transName(g.title) }}</option>
                        </select>
                    </div>
                    <a class="filter-a" @click="cancelFilters">
                        <img src="/images/close.svg" alt="Отменить" title="Отменить"/>
                    </a>
                </div>
                <div class="row" id="dynamic-afisha">
                    @include('content.home.home__events_dynamic', compact('events'))
                </div>
                <div v-if="paginator && paginator.current_page < paginator.last_page" class="text-center mt-4">
                    <a @click="more" class="btn-loadmore">Показать еще</a>
                </div>
            </div>
        </div>
    </div>
</section>
