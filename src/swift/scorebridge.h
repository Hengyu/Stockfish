//
//  scoreinfo.h
//  CoreChess
//
//  Created by hengyu on 5/7/25.
//

#ifndef SCOREBRIDGE_H
#define SCOREBRIDGE_H

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgnu-anonymous-struct"
#pragma clang diagnostic ignored "-Wnested-anon-types"

typedef enum {
    ScoreKindMate      = 0,
    ScoreKindTablebase = 1,
    ScoreKindUnits     = 2
} ScoreKind;

typedef struct {
    ScoreKind kind;
    union {
        struct {
            int plies;
        } mate;
        struct {
            int plies;
            // A value of 1 indicates a win for the white player; any other value indicates a draw or loss for white.
            int win;
        } tablebase;
        struct {
            int value;
        } units;
    };
} ScoreBridge;

#pragma clang diagnostic pop

#endif
