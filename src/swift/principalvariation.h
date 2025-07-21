//
//  principalvariation.h
//  CoreChess
//
//  Created by hengyu on 5/7/25.
//

#ifndef PRINCIPALVARIATION_H
#define PRINCIPALVARIATION_H

#include <vector>
#include <string>

#include "../types.h"
#include "scorebridge.h"

// Structure to hold principal variation information for reporting to iOS
typedef struct {
    std::vector<Stockfish::Move> moves;
    ScoreBridge                  score;
    int                          depth;
    int                          selectiveDepth;
    std::string                  winDrawlose;
    size_t                       nodes;
    size_t                       time;
} PrincipalVariationInfo;

#endif  // PRINCIPALVARIATION_H
