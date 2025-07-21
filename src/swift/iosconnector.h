#ifndef IOSCONNECTOR_H
#define IOSCONNECTOR_H

#include "../types.h"
#include "scorebridge.h"
#include "principalvariation.h"

extern void principal_variation(const PrincipalVariationInfo* info);
extern void searched_move(const Stockfish::Move& currmove, unsigned long currmovenum, int depth);
extern void best_move(const Stockfish::Move& best, const Stockfish::Move& ponder);
extern void position_is_draw();

#endif  // IOSCONNECTOR_H
