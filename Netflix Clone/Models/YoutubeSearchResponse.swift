//
//  YoutubeSearchResponse.swift
//  Netflix Clone
//
//  Created by Yun Ni on 2024-06-17.
//

import Foundation

struct YoutubeSearchResponse: Codable {
    
    let items: [VideoElement]
    
}

struct VideoElement: Codable {
    
    let id: IdVideoElement
    
}

struct IdVideoElement: Codable {
    let kind: String
    let videoId: String
}

//items =     (
//            {
//        etag = "hRDnezx4LRSTgVpV-pRPp6iUe5o";
//        id =             {
//            channelId = "UChPRO1CB_Hvd0TvKRU62iSQ";
//            kind = "youtube#channel";
//        };
//        kind = "youtube#searchResult";
//    },
//            {
//        etag = "w3NeIrVz5Hqy_is34-u4AP6tAAI";
//        id =             {
//            kind = "youtube#video";
//            videoId = xHGgUujQr0w;
//        };
//        kind = "youtube#searchResult";
//    },
//            {
//        etag = KOqICPepid9jhE6VpCl3TVuxxhA;
//        id =             {
//            kind = "youtube#video";
//            videoId = ZUywntRSAq0;
//        };
//        kind = "youtube#searchResult";
//    },
//            {
//        etag = yfIiyOHYEgfCknrtnvKsDV3G01U;
//        id =             {
//            kind = "youtube#video";
//            videoId = EqVUDmyURZ4;
//        };
//        kind = "youtube#searchResult";
//    },
//            {
//        etag = "zVUdYoYNuccpXIyV-RwWwPa05mE";
//        id =             {
//            kind = "youtube#video";
//            videoId = "_dJH0RxSQK4";
//        };
//        kind = "youtube#searchResult";
//    }
//);
//kind = "youtube#searchListResponse";
//nextPageToken = CAUQAA;
//pageInfo =     {
//    resultsPerPage = 5;
//    totalResults = 1000000;
//};
//regionCode = CA;
//}
