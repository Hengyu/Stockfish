#ifndef IOSEXTENSION_H
#define IOSEXTENSION_H

#include <vector>

#include "types.h"

using namespace Stockfish;

extern void principal_variation(std::vector<Move> moves, const Value& score, int depth, uint64_t nodes, long long time);
extern void searched_move(const Move& currmove, unsigned long currmovenum, int depth);
extern void best_move(const Move& best, const Move& ponder, const Value& score);
extern void position_is_draw(void);

#endif // !defined(IPHONE_H_INCLUDED)
