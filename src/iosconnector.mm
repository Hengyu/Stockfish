#import "iosconnector.h"
#import "uci.h"

#import "../../include/CEngine.h"
#import "../../include/CMove.h"
#import "../../include/CPrincipalVariation.h"
#import "../../include/CResult.h"
#import "../../include/CSearchedMove.h"
#import "../../include/CScore.h"

#import "../../CEngine/CEngine_Private.h"
#import "../../CEngine/CMove_Private.h"
#import "../../CEngine/CPrincipalVariation_Private.h"

void principal_variation(std::vector<Move> moves, const Value& score, int depth, uint64_t nodes, long long time) {
    NSMutableArray<CMove *> *array = [NSMutableArray array];
    for (Move m : moves) {
        CMove *c = [[CMove alloc] initWithMove:m];
        [array addObject:c];
    }

    CScore *cscore;
    if (abs(score) < VALUE_MATE - MAX_PLY) {
        cscore = [[CScore alloc] initWithValue:score * 100 / UCI::NormalizeToPawnValue mates:NO];
    } else {
        cscore = [[CScore alloc] initWithValue:(score > 0 ? VALUE_MATE - score + 1 : -VALUE_MATE - score) / 2 mates:TRUE];
    }

    CEngine *engine = [CEngine sharedEngine];
    CPrincipalVariation *pv = [[CPrincipalVariation alloc] initWithMoves:array score:cscore  depth:depth nodes:nodes time:time];
    [engine sendPrincipalVariation:pv];
}

void searched_move(const Move& currmove, unsigned long currmovenum, int depth) {
    CSearchedMove *c = [[CSearchedMove alloc] initWithMove:currmove];
    c.number = (NSUInteger)currmovenum;
    c.depth = (NSUInteger)depth;
    CEngine *engine = [CEngine sharedEngine];
    [engine sendSearchedMove:c];
}

void best_move(const Move& best, const Move& ponder, const Value& score) {
    CEngine *engine = [CEngine sharedEngine];
    CMove *b = [[CMove alloc] initWithMove:best];
    CMove *p = [[CMove alloc] initWithMove:ponder];
    CScore *cscore;
    if (abs(score) < VALUE_MATE - MAX_PLY) {
        cscore = [[CScore alloc] initWithValue:score * 100 / UCI::NormalizeToPawnValue mates:NO];
    } else {
        cscore = [[CScore alloc] initWithValue:(score > 0 ? VALUE_MATE - score + 1 : -VALUE_MATE - score) / 2 mates:TRUE];
    }
    CResult *r = [[CResult alloc] initWithBestMove:b ponderMove:p score:cscore];
    if (best != MOVE_NONE) {
        [engine sendResult:r];
    } else {
        [engine sendPositionIsMate];
    }
}

void position_is_draw(void) {
    CEngine *engine = [CEngine sharedEngine];
    [engine sendPositionIsDraw];
}
