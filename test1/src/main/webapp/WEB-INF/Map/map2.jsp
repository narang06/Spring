<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9e6699c5174a23140124c4420ab222c8&libraries=services"></script>
    <style>
        .map_wrap, .map_wrap * {margin:0;padding:0;font-family:'Malgun Gothic',dotum,'돋움',sans-serif;font-size:12px;}
        .map_wrap a, .map_wrap a:hover, .map_wrap a:active{color:#000;text-decoration: none;}
        .map_wrap {position:relative;width:100%;height:500px;}
        #menu_wrap {position:absolute;top:0;left:0;bottom:0;width:250px;margin:10px 0 30px 10px;padding:5px;overflow-y:auto;background:rgba(255, 255, 255, 0.7);z-index: 1;font-size:12px;border-radius: 10px;}
        .bg_white {background:#fff;}
        #menu_wrap hr {display: block; height: 1px;border: 0; border-top: 2px solid #5F5F5F;margin:3px 0;}
        #menu_wrap .option{text-align: center;}
        #menu_wrap .option p {margin:10px 0;}  
        #menu_wrap .option button {margin-left:5px;}
        #placesList li {list-style: none;}
        #placesList .item {position:relative;border-bottom:1px solid #888;overflow: hidden;cursor: pointer;min-height: 65px;}
        #placesList .item span {display: block;margin-top:4px;}
        #placesList .item h5, #placesList .item .info {text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
        #placesList .item .info{padding:10px 0 10px 55px;}
        #placesList .info .gray {color:#8a8a8a;}
        #placesList .info .jibun {padding-left:26px;background:url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_jibun.png) no-repeat;}
        #placesList .info .tel {color:#009900;}
        #placesList .item .markerbg {float:left;position:absolute;width:36px; height:37px;margin:10px 0 0 10px;background:url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png) no-repeat;}
        #placesList .item .marker_1 {background-position: 0 -10px;}
        #placesList .item .marker_2 {background-position: 0 -56px;}
        #placesList .item .marker_3 {background-position: 0 -102px}
        #placesList .item .marker_4 {background-position: 0 -148px;}
        #placesList .item .marker_5 {background-position: 0 -194px;}
        #placesList .item .marker_6 {background-position: 0 -240px;}
        #placesList .item .marker_7 {background-position: 0 -286px;}
        #placesList .item .marker_8 {background-position: 0 -332px;}
        #placesList .item .marker_9 {background-position: 0 -378px;}
        #placesList .item .marker_10 {background-position: 0 -423px;}
        #placesList .item .marker_11 {background-position: 0 -470px;}
        #placesList .item .marker_12 {background-position: 0 -516px;}
        #placesList .item .marker_13 {background-position: 0 -562px;}
        #placesList .item .marker_14 {background-position: 0 -608px;}
        #placesList .item .marker_15 {background-position: 0 -654px;}
        #pagination {margin:10px auto;text-align: center;}
        #pagination a {display:inline-block;margin-right:10px;}
        #pagination .on {font-weight: bold; cursor: default;color:#777;}
    </style>
</head>
<body>
    <div id="app">
        <div class="map_wrap">
            <div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>

            <div id="menu_wrap" class="bg_white">
                <div class="option">
                    <div>
                        <form @submit.prevent="searchPlaces"> 
                            키워드 : <input type="text" value="이태원 맛집" id="keyword" size="15"> 
                            <button type="submit">검색하기</button> 
                        </form>
                    </div>
                </div>
                <hr>
                <ul id="placesList"></ul>
                <div id="pagination"></div>
            </div>
        </div>
    </div>
</body>
</html>
<script>
    const app = Vue.createApp({
        data() {
            return {
                map: null, // 지도 객체
                ps: null, // 장소 검색 객체
                infowindow: null, // 인포윈도우 객체
                markers: [] // 마커 배열
            };
        },
        methods: {
            searchPlaces() {
                var keyword = document.getElementById('keyword').value;

                if (!keyword.replace(/^\s+|\s+$/g, '')) {
                    alert('키워드를 입력해주세요!');
                    return false;
                }

                // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다 (this.ps 사용 및 콜백 바인딩)
                this.ps.keywordSearch( keyword, this.placesSearchCB.bind(this)); 
            },

            // 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
            placesSearchCB(data, status, pagination) {
                if (status === kakao.maps.services.Status.OK) {

                    // 정상적으로 검색이 완료됐으면 (this.displayPlaces 사용)
                    this.displayPlaces(data);

                    // 페이지 번호를 표출합니다 (this.displayPagination 사용)
                    this.displayPagination(pagination);

                } else if (status === kakao.maps.services.Status.ZERO_RESULT) {

                    alert('검색 결과가 존재하지 않습니다.');
                    return;

                } else if (status === kakao.maps.services.Status.ERROR) {

                    alert('검색 결과 중 오류가 발생했습니다.');
                    return;

                }
            },

            // 검색 결과 목록과 마커를 표출하는 함수입니다
            displayPlaces(places) {

                var listEl = document.getElementById('placesList'), 
                menuEl = document.getElementById('menu_wrap'),
                fragment = document.createDocumentFragment(), 
                bounds = new kakao.maps.LatLngBounds(), 
                listStr = '';
                
                // 검색 결과 목록에 추가된 항목들을 제거합니다 (this.removeAllChildNods 사용)
                this.removeAllChildNods(listEl);

                // 지도에 표시되고 있는 마커를 제거합니다 (this.removeMarker 사용)
                this.removeMarker();
                
                for ( let i=0; i<places.length; i++ ) {

                    // 마커를 생성하고 지도에 표시합니다 (this.addMarker 사용)
                    var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
                        marker = this.addMarker(placePosition, i), 
                        // 검색 결과 항목 Element를 생성합니다 (this.getListItem 사용)
                        itemEl = this.getListItem(i, places[i]); 

                    // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
                    // LatLngBounds 객체에 좌표를 추가합니다
                    bounds.extend(placePosition);

                    // 마커와 검색결과 항목에 mouseover 했을때
                    // 해당 장소에 인포윈도우에 장소명을 표시합니다
                    // mouseout 했을 때는 인포윈도우를 닫습니다
                    
                    // 인포윈도우 표시/닫기 함수에 this를 바인딩합니다.
                    kakao.maps.event.addListener(marker, 'mouseover', () => {
                        this.displayInfowindow(marker, places[i].place_name);
                    });

                    kakao.maps.event.addListener(marker, 'mouseout', () => {
                        this.infowindow.close(); // this.infowindow 사용
                    });

                    itemEl.onmouseover =  () => {
                        this.displayInfowindow(marker, places[i].place_name);
                    };

                    itemEl.onmouseout =  () => {
                        this.infowindow.close(); // this.infowindow 사용
                    };

                    fragment.appendChild(itemEl);
                }

                // 검색결과 항목들을 검색결과 목록 Element에 추가합니다
                listEl.appendChild(fragment);
                menuEl.scrollTop = 0;

                // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다 (this.map 사용)
                this.map.setBounds(bounds);
            },

            // 검색결과 항목을 Element로 반환하는 함수입니다
            getListItem(index, places) {

                var el = document.createElement('li'),
                itemStr = '<span class="markerbg marker_' + (index+1) + '"></span>' +
                            '<div class="info">' +
                            '   <h5>' + places.place_name + '</h5>';

                if (places.road_address_name) {
                    itemStr += '    <span>' + places.road_address_name + '</span>' +
                                '   <span class="jibun gray">' +  places.address_name  + '</span>';
                } else {
                    itemStr += '    <span>' +  places.address_name  + '</span>'; 
                }
                        
                itemStr += '  <span class="tel">' + places.phone  + '</span>' +
                            '</div>';           

                el.innerHTML = itemStr;
                el.className = 'item';

                return el;
            },

            // 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
            addMarker(position, idx) { // title은 사용되지 않아 제거했습니다.
                var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
                    imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
                    imgOptions =  {
                        spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
                        spriteOrigin : new kakao.maps.Point(0, (idx*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
                        offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
                    },
                    markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
                        marker = new kakao.maps.Marker({
                        position: position, // 마커의 위치
                        image: markerImage 
                    });

                marker.setMap(this.map); // this.map 사용
                this.markers.push(marker);  // this.markers 사용

                return marker;
            },

            // 지도 위에 표시되고 있는 마커를 모두 제거합니다
            removeMarker() {
                for ( var i = 0; i < this.markers.length; i++ ) { // this.markers 사용
                    this.markers[i].setMap(null);
                }   
                this.markers = []; // this.markers 사용
            },

            // 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
            displayPagination(pagination) {
                var paginationEl = document.getElementById('pagination'),
                    fragment = document.createDocumentFragment(),
                    i; 

                // 기존에 추가된 페이지번호를 삭제합니다
                while (paginationEl.hasChildNodes()) {
                    paginationEl.removeChild (paginationEl.lastChild);
                }

                for (i=1; i<=pagination.last; i++) {
                    var el = document.createElement('a');
                    el.href = "#";
                    el.innerHTML = i;

                    if (i===pagination.current) {
                        el.className = 'on';
                    } else {
                        el.onclick = (function(i) {
                            return function() {
                                pagination.gotoPage(i);
                            }
                        })(i);
                    }

                    fragment.appendChild(el);
                }
                paginationEl.appendChild(fragment);
            },

            // 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
            // 인포윈도우에 장소명을 표시합니다
            displayInfowindow(marker, title) {
                var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';

                this.infowindow.setContent(content); // this.infowindow 사용
                this.infowindow.open(this.map, marker); // this.infowindow, this.map 사용
            },

            // 검색결과 목록의 자식 Element를 제거하는 함수입니다
            removeAllChildNods(el) {   
                while (el.hasChildNodes()) {
                    el.removeChild (el.lastChild);
                }
            },
           
        }, // methods
        mounted() {
            // mounted 내부의 지역 변수 선언을 제거하고 this.변수명으로 data에 할당합니다.

            var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
                mapOption = {
                    center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
                    level: 3 // 지도의 확대 레벨
                };  

            // 지도를 생성하고 this.map에 할당합니다.    
            this.map = new kakao.maps.Map(mapContainer, mapOption); 

            // 장소 검색 객체를 생성하고 this.ps에 할당합니다.
            this.ps = new kakao.maps.services.Places(this.map);  

            // 인포윈도우를 생성하고 this.infowindow에 할당합니다.
            this.infowindow = new kakao.maps.InfoWindow({zIndex:1});

            // 키워드로 장소를 검색합니다 (this.searchPlaces 사용)
            this.searchPlaces();
        }
    });

    app.mount('#app');
</script>