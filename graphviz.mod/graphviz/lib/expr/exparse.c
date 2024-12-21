/* A Bison parser, made by GNU Bison 3.5.1.  */

/* Bison implementation for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2020 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* C LALR(1) parser skeleton written by Richard Stallman, by
   simplifying the original so-called "semantic" parser.  */

/* All symbols defined below should begin with yy or YY, to avoid
   infringing on user name space.  This should be done even for local
   variables, as they might otherwise be expanded by user macros.
   There are some unavoidable exceptions within include files to
   define necessary library symbols; they are noted "INFRINGES ON
   USER NAME SPACE" below.  */

/* Undocumented macros, especially those whose name start with YY_,
   are private implementation details.  Do not rely on them.  */

/* Identify Bison output.  */
#define YYBISON 1

/* Bison version.  */
#define YYBISON_VERSION "3.5.1"

/* Skeleton name.  */
#define YYSKELETON_NAME "yacc.c"

/* Pure parsers.  */
#define YYPURE 0

/* Push parsers.  */
#define YYPUSH 0

/* Pull parsers.  */
#define YYPULL 1

/* Substitute the type names.  */
#define YYSTYPE         EX_STYPE
/* Substitute the variable and function names.  */
#define yyparse         ex_parse
#define yylex           ex_lex
#define yyerror         ex_error
#define yydebug         ex_debug
#define yynerrs         ex_nerrs
#define yylval          ex_lval
#define yychar          ex_char

/* First part of user prologue.  */
#line 19 "../../lib/expr/exparse.y"


/*
 * Glenn Fowler
 * AT&T Research
 *
 * expression library grammar and compiler
 */

#include <assert.h>
#include <cgraph/gv_ctype.h>
#include <expr/exop.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ast/ast.h>
#include <util/streq.h>


#line 99 "exparse.c"

# ifndef YY_CAST
#  ifdef __cplusplus
#   define YY_CAST(Type, Val) static_cast<Type> (Val)
#   define YY_REINTERPRET_CAST(Type, Val) reinterpret_cast<Type> (Val)
#  else
#   define YY_CAST(Type, Val) ((Type) (Val))
#   define YY_REINTERPRET_CAST(Type, Val) ((Type) (Val))
#  endif
# endif
# ifndef YY_NULLPTR
#  if defined __cplusplus
#   if 201103L <= __cplusplus
#    define YY_NULLPTR nullptr
#   else
#    define YY_NULLPTR 0
#   endif
#  else
#   define YY_NULLPTR ((void*)0)
#  endif
# endif

/* Enabling verbose error messages.  */
#ifdef YYERROR_VERBOSE
# undef YYERROR_VERBOSE
# define YYERROR_VERBOSE 1
#else
# define YYERROR_VERBOSE 0
#endif

/* Use api.header.include to #include this header
   instead of duplicating it here.  */
#ifndef YY_EX_EXPARSE_H_INCLUDED
# define YY_EX_EXPARSE_H_INCLUDED
/* Debug traces.  */
#ifndef EX_DEBUG
# if defined YYDEBUG
#if YYDEBUG
#   define EX_DEBUG 1
#  else
#   define EX_DEBUG 0
#  endif
# else /* ! defined YYDEBUG */
#  define EX_DEBUG 1
# endif /* ! defined YYDEBUG */
#endif  /* ! defined EX_DEBUG */
#if EX_DEBUG
extern int ex_debug;
#endif

/* Token type.  */
#ifndef EX_TOKENTYPE
# define EX_TOKENTYPE
  enum ex_tokentype
  {
    MINTOKEN = 258,
    INTEGER = 259,
    UNSIGNED = 260,
    CHARACTER = 261,
    FLOATING = 262,
    STRING = 263,
    VOIDTYPE = 264,
    ADDRESS = 265,
    ARRAY = 266,
    BREAK = 267,
    CALL = 268,
    CASE = 269,
    CONSTANT = 270,
    CONTINUE = 271,
    DECLARE = 272,
    DEFAULT = 273,
    DYNAMIC = 274,
    ELSE = 275,
    EXIT = 276,
    FOR = 277,
    FUNCTION = 278,
    GSUB = 279,
    ITERATE = 280,
    ITERATOR = 281,
    ID = 282,
    IF = 283,
    LABEL = 284,
    MEMBER = 285,
    NAME = 286,
    POS = 287,
    PRAGMA = 288,
    PRE = 289,
    PRINT = 290,
    PRINTF = 291,
    PROCEDURE = 292,
    QUERY = 293,
    RAND = 294,
    RETURN = 295,
    SCANF = 296,
    SPLIT = 297,
    SPRINTF = 298,
    SRAND = 299,
    SSCANF = 300,
    SUB = 301,
    SUBSTR = 302,
    SWITCH = 303,
    TOKENS = 304,
    UNSET = 305,
    WHILE = 306,
    F2I = 307,
    F2S = 308,
    I2F = 309,
    I2S = 310,
    S2B = 311,
    S2F = 312,
    S2I = 313,
    F2X = 314,
    I2X = 315,
    S2X = 316,
    X2F = 317,
    X2I = 318,
    X2S = 319,
    X2X = 320,
    XPRINT = 321,
    OR = 322,
    AND = 323,
    EQ = 324,
    NE = 325,
    LE = 326,
    GE = 327,
    LSH = 328,
    RSH = 329,
    IN_OP = 330,
    UNARY = 331,
    INC = 332,
    DEC = 333,
    CAST = 334,
    MAXTOKEN = 335
  };
#endif
/* Tokens.  */
#define MINTOKEN 258
#define INTEGER 259
#define UNSIGNED 260
#define CHARACTER 261
#define FLOATING 262
#define STRING 263
#define VOIDTYPE 264
#define ADDRESS 265
#define ARRAY 266
#define BREAK 267
#define CALL 268
#define CASE 269
#define CONSTANT 270
#define CONTINUE 271
#define DECLARE 272
#define DEFAULT 273
#define DYNAMIC 274
#define ELSE 275
#define EXIT 276
#define FOR 277
#define FUNCTION 278
#define GSUB 279
#define ITERATE 280
#define ITERATOR 281
#define ID 282
#define IF 283
#define LABEL 284
#define MEMBER 285
#define NAME 286
#define POS 287
#define PRAGMA 288
#define PRE 289
#define PRINT 290
#define PRINTF 291
#define PROCEDURE 292
#define QUERY 293
#define RAND 294
#define RETURN 295
#define SCANF 296
#define SPLIT 297
#define SPRINTF 298
#define SRAND 299
#define SSCANF 300
#define SUB 301
#define SUBSTR 302
#define SWITCH 303
#define TOKENS 304
#define UNSET 305
#define WHILE 306
#define F2I 307
#define F2S 308
#define I2F 309
#define I2S 310
#define S2B 311
#define S2F 312
#define S2I 313
#define F2X 314
#define I2X 315
#define S2X 316
#define X2F 317
#define X2I 318
#define X2S 319
#define X2X 320
#define XPRINT 321
#define OR 322
#define AND 323
#define EQ 324
#define NE 325
#define LE 326
#define GE 327
#define LSH 328
#define RSH 329
#define IN_OP 330
#define UNARY 331
#define INC 332
#define DEC 333
#define CAST 334
#define MAXTOKEN 335

/* Value type.  */
#if ! defined EX_STYPE && ! defined EX_STYPE_IS_DECLARED
union EX_STYPE
{
#line 41 "../../lib/expr/exparse.y"

	struct Exnode_s*expr;
	double		floating;
	struct Exref_s*	reference;
	struct Exid_s*	id;
	long long integer;
	int		op;
	char*		string;

#line 329 "exparse.c"

};
typedef union EX_STYPE EX_STYPE;
# define EX_STYPE_IS_TRIVIAL 1
# define EX_STYPE_IS_DECLARED 1
#endif


extern EX_STYPE ex_lval;

int ex_parse (void);

#endif /* !YY_EX_EXPARSE_H_INCLUDED  */

/* Second part of user prologue.  */
#line 169 "../../lib/expr/exparse.y"


#include <expr/exgram.h>

void ex_error(const char *message);


#line 353 "exparse.c"


#ifdef short
# undef short
#endif

/* On compilers that do not define __PTRDIFF_MAX__ etc., make sure
   <limits.h> and (if available) <stdint.h> are included
   so that the code can choose integer types of a good width.  */

#ifndef __PTRDIFF_MAX__
# include <limits.h> /* INFRINGES ON USER NAME SPACE */
# if defined __STDC_VERSION__ && 199901 <= __STDC_VERSION__
#  include <stdint.h> /* INFRINGES ON USER NAME SPACE */
#  define YY_STDINT_H
# endif
#endif

/* Narrow types that promote to a signed type and that can represent a
   signed or unsigned integer of at least N bits.  In tables they can
   save space and decrease cache pressure.  Promoting to a signed type
   helps avoid bugs in integer arithmetic.  */

#ifdef __INT_LEAST8_MAX__
typedef __INT_LEAST8_TYPE__ yytype_int8;
#elif defined YY_STDINT_H
typedef int_least8_t yytype_int8;
#else
typedef signed char yytype_int8;
#endif

#ifdef __INT_LEAST16_MAX__
typedef __INT_LEAST16_TYPE__ yytype_int16;
#elif defined YY_STDINT_H
typedef int_least16_t yytype_int16;
#else
typedef short yytype_int16;
#endif

#if defined __UINT_LEAST8_MAX__ && __UINT_LEAST8_MAX__ <= __INT_MAX__
typedef __UINT_LEAST8_TYPE__ yytype_uint8;
#elif (!defined __UINT_LEAST8_MAX__ && defined YY_STDINT_H \
       && UINT_LEAST8_MAX <= INT_MAX)
typedef uint_least8_t yytype_uint8;
#elif !defined __UINT_LEAST8_MAX__ && UCHAR_MAX <= INT_MAX
typedef unsigned char yytype_uint8;
#else
typedef short yytype_uint8;
#endif

#if defined __UINT_LEAST16_MAX__ && __UINT_LEAST16_MAX__ <= __INT_MAX__
typedef __UINT_LEAST16_TYPE__ yytype_uint16;
#elif (!defined __UINT_LEAST16_MAX__ && defined YY_STDINT_H \
       && UINT_LEAST16_MAX <= INT_MAX)
typedef uint_least16_t yytype_uint16;
#elif !defined __UINT_LEAST16_MAX__ && USHRT_MAX <= INT_MAX
typedef unsigned short yytype_uint16;
#else
typedef int yytype_uint16;
#endif

#ifndef YYPTRDIFF_T
# if defined __PTRDIFF_TYPE__ && defined __PTRDIFF_MAX__
#  define YYPTRDIFF_T __PTRDIFF_TYPE__
#  define YYPTRDIFF_MAXIMUM __PTRDIFF_MAX__
# elif defined PTRDIFF_MAX
#  ifndef ptrdiff_t
#   include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  endif
#  define YYPTRDIFF_T ptrdiff_t
#  define YYPTRDIFF_MAXIMUM PTRDIFF_MAX
# else
#  define YYPTRDIFF_T long
#  define YYPTRDIFF_MAXIMUM LONG_MAX
# endif
#endif

#ifndef YYSIZE_T
# ifdef __SIZE_TYPE__
#  define YYSIZE_T __SIZE_TYPE__
# elif defined size_t
#  define YYSIZE_T size_t
# elif defined __STDC_VERSION__ && 199901 <= __STDC_VERSION__
#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  define YYSIZE_T size_t
# else
#  define YYSIZE_T unsigned
# endif
#endif

#define YYSIZE_MAXIMUM                                  \
  YY_CAST (YYPTRDIFF_T,                                 \
           (YYPTRDIFF_MAXIMUM < YY_CAST (YYSIZE_T, -1)  \
            ? YYPTRDIFF_MAXIMUM                         \
            : YY_CAST (YYSIZE_T, -1)))

#define YYSIZEOF(X) YY_CAST (YYPTRDIFF_T, sizeof (X))

/* Stored state numbers (used for stacks). */
typedef yytype_int16 yy_state_t;

/* State numbers in computations.  */
typedef int yy_state_fast_t;

#ifndef YY_
# if defined YYENABLE_NLS && YYENABLE_NLS
#  if ENABLE_NLS
#   include <libintl.h> /* INFRINGES ON USER NAME SPACE */
#   define YY_(Msgid) dgettext ("bison-runtime", Msgid)
#  endif
# endif
# ifndef YY_
#  define YY_(Msgid) Msgid
# endif
#endif

#ifndef YY_ATTRIBUTE_PURE
# if defined __GNUC__ && 2 < __GNUC__ + (96 <= __GNUC_MINOR__)
#  define YY_ATTRIBUTE_PURE __attribute__ ((__pure__))
# else
#  define YY_ATTRIBUTE_PURE
# endif
#endif

#ifndef YY_ATTRIBUTE_UNUSED
# if defined __GNUC__ && 2 < __GNUC__ + (7 <= __GNUC_MINOR__)
#  define YY_ATTRIBUTE_UNUSED __attribute__ ((__unused__))
# else
#  define YY_ATTRIBUTE_UNUSED
# endif
#endif

/* Suppress unused-variable warnings by "using" E.  */
#if ! defined lint || defined __GNUC__
# define YYUSE(E) ((void) (E))
#else
# define YYUSE(E) /* empty */
#endif

#if defined __GNUC__ && ! defined __ICC && 407 <= __GNUC__ * 100 + __GNUC_MINOR__
/* Suppress an incorrect diagnostic about yylval being uninitialized.  */
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN                            \
    _Pragma ("GCC diagnostic push")                                     \
    _Pragma ("GCC diagnostic ignored \"-Wuninitialized\"")              \
    _Pragma ("GCC diagnostic ignored \"-Wmaybe-uninitialized\"")
# define YY_IGNORE_MAYBE_UNINITIALIZED_END      \
    _Pragma ("GCC diagnostic pop")
#else
# define YY_INITIAL_VALUE(Value) Value
#endif
#ifndef YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_END
#endif
#ifndef YY_INITIAL_VALUE
# define YY_INITIAL_VALUE(Value) /* Nothing. */
#endif

#if defined __cplusplus && defined __GNUC__ && ! defined __ICC && 6 <= __GNUC__
# define YY_IGNORE_USELESS_CAST_BEGIN                          \
    _Pragma ("GCC diagnostic push")                            \
    _Pragma ("GCC diagnostic ignored \"-Wuseless-cast\"")
# define YY_IGNORE_USELESS_CAST_END            \
    _Pragma ("GCC diagnostic pop")
#endif
#ifndef YY_IGNORE_USELESS_CAST_BEGIN
# define YY_IGNORE_USELESS_CAST_BEGIN
# define YY_IGNORE_USELESS_CAST_END
#endif


#define YY_ASSERT(E) ((void) (0 && (E)))

#if ! defined yyoverflow || YYERROR_VERBOSE

/* The parser invokes alloca or malloc; define the necessary symbols.  */

# ifdef YYSTACK_USE_ALLOCA
#  if YYSTACK_USE_ALLOCA
#   ifdef __GNUC__
#    define YYSTACK_ALLOC __builtin_alloca
#   elif defined __BUILTIN_VA_ARG_INCR
#    include <alloca.h> /* INFRINGES ON USER NAME SPACE */
#   elif defined _AIX
#    define YYSTACK_ALLOC __alloca
#   elif defined _MSC_VER
#    include <malloc.h> /* INFRINGES ON USER NAME SPACE */
#    define alloca _alloca
#   else
#    define YYSTACK_ALLOC alloca
#    if ! defined _ALLOCA_H && ! defined EXIT_SUCCESS
#     include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
      /* Use EXIT_SUCCESS as a witness for stdlib.h.  */
#     ifndef EXIT_SUCCESS
#      define EXIT_SUCCESS 0
#     endif
#    endif
#   endif
#  endif
# endif

# ifdef YYSTACK_ALLOC
   /* Pacify GCC's 'empty if-body' warning.  */
#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (0)
#  ifndef YYSTACK_ALLOC_MAXIMUM
    /* The OS might guarantee only one guard page at the bottom of the stack,
       and a page size can be as small as 4096 bytes.  So we cannot safely
       invoke alloca (N) if N exceeds 4096.  Use a slightly smaller number
       to allow for a few compiler-allocated temporary stack slots.  */
#   define YYSTACK_ALLOC_MAXIMUM 4032 /* reasonable circa 2006 */
#  endif
# else
#  define YYSTACK_ALLOC YYMALLOC
#  define YYSTACK_FREE YYFREE
#  ifndef YYSTACK_ALLOC_MAXIMUM
#   define YYSTACK_ALLOC_MAXIMUM YYSIZE_MAXIMUM
#  endif
#  if (defined __cplusplus && ! defined EXIT_SUCCESS \
       && ! ((defined YYMALLOC || defined malloc) \
             && (defined YYFREE || defined free)))
#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#   ifndef EXIT_SUCCESS
#    define EXIT_SUCCESS 0
#   endif
#  endif
#  ifndef YYMALLOC
#   define YYMALLOC malloc
#   if ! defined malloc && ! defined EXIT_SUCCESS
void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
#  ifndef YYFREE
#   define YYFREE free
#   if ! defined free && ! defined EXIT_SUCCESS
void free (void *); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
# endif
#endif /* ! defined yyoverflow || YYERROR_VERBOSE */


#if (! defined yyoverflow \
     && (! defined __cplusplus \
         || (defined EX_STYPE_IS_TRIVIAL && EX_STYPE_IS_TRIVIAL)))

/* A type that is properly aligned for any stack member.  */
union yyalloc
{
  yy_state_t yyss_alloc;
  YYSTYPE yyvs_alloc;
};

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (YYSIZEOF (union yyalloc) - 1)

/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# define YYSTACK_BYTES(N) \
     ((N) * (YYSIZEOF (yy_state_t) + YYSIZEOF (YYSTYPE)) \
      + YYSTACK_GAP_MAXIMUM)

# define YYCOPY_NEEDED 1

/* Relocate STACK from its old location to the new one.  The
   local variables YYSIZE and YYSTACKSIZE give the old and new number of
   elements in the stack, and YYPTR gives the new location of the
   stack.  Advance YYPTR to a properly aligned location for the next
   stack.  */
# define YYSTACK_RELOCATE(Stack_alloc, Stack)                           \
    do                                                                  \
      {                                                                 \
        YYPTRDIFF_T yynewbytes;                                         \
        YYCOPY (&yyptr->Stack_alloc, Stack, yysize);                    \
        Stack = &yyptr->Stack_alloc;                                    \
        yynewbytes = yystacksize * YYSIZEOF (*Stack) + YYSTACK_GAP_MAXIMUM; \
        yyptr += yynewbytes / YYSIZEOF (*yyptr);                        \
      }                                                                 \
    while (0)

#endif

#if defined YYCOPY_NEEDED && YYCOPY_NEEDED
/* Copy COUNT objects from SRC to DST.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if defined __GNUC__ && 1 < __GNUC__
#   define YYCOPY(Dst, Src, Count) \
      __builtin_memcpy (Dst, Src, YY_CAST (YYSIZE_T, (Count)) * sizeof (*(Src)))
#  else
#   define YYCOPY(Dst, Src, Count)              \
      do                                        \
        {                                       \
          YYPTRDIFF_T yyi;                      \
          for (yyi = 0; yyi < (Count); yyi++)   \
            (Dst)[yyi] = (Src)[yyi];            \
        }                                       \
      while (0)
#  endif
# endif
#endif /* !YYCOPY_NEEDED */

/* YYFINAL -- State number of the termination state.  */
#define YYFINAL  3
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   1118

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  106
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  42
/* YYNRULES -- Number of rules.  */
#define YYNRULES  139
/* YYNSTATES -- Number of states.  */
#define YYNSTATES  283

#define YYUNDEFTOK  2
#define YYMAXUTOK   335


/* YYTRANSLATE(TOKEN-NUM) -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex, with out-of-bounds checking.  */
#define YYTRANSLATE(YYX)                                                \
  (0 <= (YYX) && (YYX) <= YYMAXUTOK ? yytranslate[YYX] : YYUNDEFTOK)

/* YYTRANSLATE[TOKEN-NUM] -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex.  */
static const yytype_int8 yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,    90,     2,    92,     2,    89,    75,     2,
      97,   102,    87,    84,    67,    85,   105,    88,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,    70,   101,
      78,    68,    79,    69,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,   103,     2,   104,    74,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,    99,    73,   100,    91,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
       5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
      15,    16,    17,    18,    19,    20,    21,    22,    23,    24,
      25,    26,    27,    28,    29,    30,    31,    32,    33,    34,
      35,    36,    37,    38,    39,    40,    41,    42,    43,    44,
      45,    46,    47,    48,    49,    50,    51,    52,    53,    54,
      55,    56,    57,    58,    59,    60,    61,    62,    63,    64,
      65,    66,    71,    72,    76,    77,    80,    81,    82,    83,
      86,    93,    94,    95,    96,    98
};

#if EX_DEBUG
  /* YYRLINE[YYN] -- Source line where rule number YYN was defined.  */
static const yytype_int16 yyrline[] =
{
       0,   179,   179,   199,   200,   203,   203,   240,   243,   258,
     262,   266,   266,   271,   281,   294,   309,   322,   330,   341,
     351,   351,   362,   374,   378,   391,   420,   423,   454,   455,
     458,   477,   483,   484,   491,   491,   539,   540,   541,   542,
     545,   546,   550,   553,   560,   563,   566,   570,   574,   627,
     631,   635,   639,   643,   647,   651,   655,   659,   663,   667,
     671,   675,   679,   683,   687,   700,   704,   714,   714,   714,
     755,   775,   782,   786,   790,   794,   798,   802,   806,   810,
     814,   818,   822,   826,   832,   836,   840,   846,   851,   855,
     880,   916,   936,   944,   952,   963,   967,   971,   974,   975,
     977,   985,   990,   995,  1000,  1007,  1008,  1009,  1012,  1013,
    1016,  1020,  1038,  1051,  1054,  1058,  1072,  1075,  1082,  1085,
    1093,  1098,  1105,  1108,  1114,  1117,  1121,  1132,  1132,  1148,
    1151,  1163,  1183,  1187,  1193,  1196,  1203,  1204,  1216,  1204
};
#endif

#if EX_DEBUG || YYERROR_VERBOSE || 1
/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "$end", "error", "$undefined", "MINTOKEN", "INTEGER", "UNSIGNED",
  "CHARACTER", "FLOATING", "STRING", "VOIDTYPE", "ADDRESS", "ARRAY",
  "BREAK", "CALL", "CASE", "CONSTANT", "CONTINUE", "DECLARE", "DEFAULT",
  "DYNAMIC", "ELSE", "EXIT", "FOR", "FUNCTION", "GSUB", "ITERATE",
  "ITERATOR", "ID", "IF", "LABEL", "MEMBER", "NAME", "POS", "PRAGMA",
  "PRE", "PRINT", "PRINTF", "PROCEDURE", "QUERY", "RAND", "RETURN",
  "SCANF", "SPLIT", "SPRINTF", "SRAND", "SSCANF", "SUB", "SUBSTR",
  "SWITCH", "TOKENS", "UNSET", "WHILE", "F2I", "F2S", "I2F", "I2S", "S2B",
  "S2F", "S2I", "F2X", "I2X", "S2X", "X2F", "X2I", "X2S", "X2X", "XPRINT",
  "','", "'='", "'?'", "':'", "OR", "AND", "'|'", "'^'", "'&'", "EQ", "NE",
  "'<'", "'>'", "LE", "GE", "LSH", "RSH", "'+'", "'-'", "IN_OP", "'*'",
  "'/'", "'%'", "'!'", "'~'", "'#'", "UNARY", "INC", "DEC", "CAST", "'('",
  "MAXTOKEN", "'{'", "'}'", "';'", "')'", "'['", "']'", "'.'", "$accept",
  "program", "action_list", "action", "$@1", "statement_list", "statement",
  "$@2", "$@3", "switch_list", "switch_item", "case_list", "case_item",
  "dcl_list", "dcl_item", "$@4", "dcl_name", "name", "else_opt",
  "expr_opt", "expr", "$@5", "$@6", "splitop", "constant", "print", "scan",
  "variable", "array", "index", "args", "arg_list", "formals",
  "formal_list", "formal_item", "$@7", "members", "member", "assign",
  "initialize", "$@8", "$@9", YY_NULLPTR
};
#endif

# ifdef YYPRINT
/* YYTOKNUM[NUM] -- (External) token number corresponding to the
   (internal) symbol number NUM (which must be that of a token).  */
static const yytype_int16 yytoknum[] =
{
       0,   256,   257,   258,   259,   260,   261,   262,   263,   264,
     265,   266,   267,   268,   269,   270,   271,   272,   273,   274,
     275,   276,   277,   278,   279,   280,   281,   282,   283,   284,
     285,   286,   287,   288,   289,   290,   291,   292,   293,   294,
     295,   296,   297,   298,   299,   300,   301,   302,   303,   304,
     305,   306,   307,   308,   309,   310,   311,   312,   313,   314,
     315,   316,   317,   318,   319,   320,   321,    44,    61,    63,
      58,   322,   323,   124,    94,    38,   324,   325,    60,    62,
     326,   327,   328,   329,    43,    45,   330,    42,    47,    37,
      33,   126,    35,   331,   332,   333,   334,    40,   335,   123,
     125,    59,    41,    91,    93,    46
};
# endif

#define YYPACT_NINF (-180)

#define yypact_value_is_default(Yyn) \
  ((Yyn) == YYPACT_NINF)

#define YYTABLE_NINF (-124)

#define yytable_value_is_error(Yyn) \
  ((Yyn) == YYTABLE_NINF)

  /* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
     STATE-NUM.  */
static const yytype_int16 yypact[] =
{
    -180,    29,   229,  -180,  -180,  -180,  -180,  -180,   -63,   711,
    -180,   711,  -180,   -41,    -7,    -4,     4,     5,     6,     1,
      10,  -180,    11,  -180,    14,  -180,    17,   711,  -180,  -180,
    -180,    20,  -180,    23,    24,    25,  -180,    27,    30,    28,
     711,   711,   711,   711,   106,    28,    28,   617,  -180,   102,
    -180,    33,   891,    38,  -180,    40,    41,    18,   711,    42,
      44,    68,   711,     1,   711,   711,   711,   711,    28,     8,
    -180,  -180,   711,   711,   711,    37,    46,   125,   711,   711,
     711,   122,   711,  -180,  -180,  -180,  -180,  -180,  -180,  -180,
    -180,    52,   312,   327,    72,  -180,  -180,   711,  -180,   711,
     711,   711,   711,   711,   711,   711,   711,   711,   711,   711,
     711,   711,   711,   711,   136,   711,   711,   711,   711,   711,
     711,   711,  -180,  -180,  -180,   935,    53,    91,  -180,  -180,
    -180,  -180,  -180,  -180,   -49,  -180,  -180,   214,  -180,   409,
      58,   -44,    73,    74,    75,    81,  -180,   506,    76,    99,
    -180,  -180,  -180,   598,   100,   101,   891,   -57,   692,   711,
    -180,  -180,  -180,   935,   711,   953,   970,   986,  1001,  1015,
    1029,  1029,   110,   110,   110,   110,    96,    96,   -73,   -73,
    -180,  -180,  -180,  -180,   914,   103,   104,   935,  -180,   711,
      68,  -180,   108,  -180,  -180,   711,   521,  -180,  -180,   521,
      61,  -180,   521,  -180,  -180,  -180,  -180,  -180,   116,   711,
    -180,   521,  -180,  -180,   868,   805,  -180,  -180,   935,  -180,
     -15,   -43,   112,  -180,  -180,  -180,   184,   113,   786,  -180,
     229,  -180,   -54,   117,  -180,  -180,  -180,  -180,   711,   521,
    -180,  -180,  -180,   711,   711,  -180,  -180,   206,   123,  -180,
      -6,   935,   834,   124,  -180,   157,  -180,   521,   111,   158,
    -180,  -180,    82,  -180,  -180,   -10,   127,   218,  -180,   161,
    -180,   229,  -180,  -180,  -180,  -180,   139,  -180,  -180,  -180,
    -180,   424,  -180
};

  /* YYDEFACT[STATE-NUM] -- Default reduction number in state STATE-NUM.
     Performed when YYTABLE does not specify something else to do.  Zero
     means the default is an error.  */
static const yytype_uint8 yydefact[] =
{
       7,     0,     3,     1,   102,   104,   101,   103,     0,    44,
     100,    44,    11,   116,     0,     0,     0,     0,     0,   129,
       0,   112,     0,   105,     0,   106,     0,    44,   108,    98,
     107,     0,   109,     0,     0,     0,    99,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     7,     2,
       8,     0,    45,     0,    97,     0,     0,   134,   118,     0,
       0,     0,     0,   129,     0,    44,   118,   118,     0,     0,
     110,   130,     0,   118,   118,     0,     0,     0,   118,   118,
       0,     0,     0,    75,    74,    73,    70,    72,    71,    92,
      95,     0,     0,    44,     0,     4,    10,     0,    67,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,   118,
     118,     0,    93,    96,    91,   120,     0,   119,    22,    23,
      37,    39,    38,    36,     0,    32,    34,     0,   111,     0,
       0,   134,     0,     0,     0,   132,   133,     0,     0,     0,
      84,    24,    85,     0,     0,     0,    20,     0,     0,     0,
      46,     9,     5,    66,     0,    65,    64,    61,    62,    60,
      58,    59,    48,    55,    56,    57,    53,    54,    63,    49,
      94,    50,    51,    52,     0,     0,     0,   135,    76,     0,
       0,    12,   113,   117,    83,    44,    44,    77,    78,    44,
       0,   131,    44,    88,    87,    86,    79,    80,     0,     0,
      17,    44,    47,     7,     0,     0,    89,    90,   121,    33,
       0,   134,     0,    14,    16,   132,    42,     0,     0,    19,
       6,    68,   116,     0,   114,   137,   136,    35,    44,    44,
      13,    25,    18,     0,     0,    81,   115,   122,     0,    43,
       0,    69,     0,   127,   138,   124,   125,    44,     0,     0,
      21,    26,     7,    28,    82,     0,     0,     0,    15,     0,
      31,    27,    29,    41,    40,   128,     0,   127,   126,    30,
       7,    44,   139
};

  /* YYPGOTO[NTERM-NUM].  */
static const yytype_int16 yypgoto[] =
{
    -180,  -180,  -180,  -180,  -180,   -48,  -179,  -180,  -180,  -180,
    -180,  -180,   -23,  -180,    57,  -180,  -180,  -180,  -180,    -8,
     -36,  -180,  -180,  -180,   -16,  -180,  -180,   -12,  -180,  -180,
      31,  -180,  -180,  -180,   -24,  -180,   186,   109,    63,  -180,
    -180,  -180
};

  /* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int16 yydefgoto[] =
{
      -1,     1,    49,    95,   213,     2,    50,    61,   208,   250,
     261,   262,   263,   134,   135,   192,   136,   275,   240,    51,
      52,   164,   243,    53,    54,    55,    56,    57,   221,    63,
     126,   127,   254,   255,   256,   265,    70,    71,   124,   237,
     247,   266
};

  /* YYTABLE[YYPACT[STATE-NUM]] -- What to do in state STATE-NUM.  If
     positive, shift that token.  If negative, reduce the rule whose
     number is the opposite.  If YYTABLE_NINF, syntax error.  */
static const yytype_int16 yytable[] =
{
      93,    59,   233,    60,    84,    85,    86,    87,   258,   273,
     209,    92,   259,   244,   115,   116,   117,   223,   190,    76,
     224,   274,   125,   226,   121,   121,   137,    83,   139,     3,
     125,   125,   229,    89,    90,   145,   147,   125,   125,   146,
      58,   153,   125,   125,   156,   210,   158,    13,   245,    62,
     122,   123,   191,   141,   235,    19,   144,   140,   196,    21,
     249,   163,    62,   165,   166,   167,   168,   169,   170,   171,
     172,   173,   174,   175,   176,   177,   178,   179,   268,   181,
     182,   183,   184,   125,   125,   187,   121,   130,   225,   234,
      64,   131,   146,    65,   260,   132,   258,   142,   143,   133,
     259,    66,    67,    68,   148,   149,    69,    72,    73,   154,
     155,    74,   122,   123,    75,     4,     5,    77,     6,     7,
      78,    79,    80,   212,    81,    88,    10,    82,   214,     4,
       5,    94,     6,     7,    96,   118,     8,   119,   120,   150,
      10,   157,   162,   128,    13,   129,    14,   151,    16,    17,
     185,   186,    19,   218,   159,   180,    21,   188,   189,   195,
      22,    23,    24,    25,    26,   230,    28,    29,    30,    31,
      32,    33,    34,   228,    36,   197,   198,   199,   203,   163,
     112,   113,   114,   115,   116,   117,   200,   222,  -124,  -124,
    -124,  -124,   110,   111,   112,   113,   114,   115,   116,   117,
      39,   204,   206,   207,   239,   216,   217,   251,   252,    40,
      41,   220,   241,   238,   271,    42,    43,    44,   227,    45,
      46,   246,    47,   253,   267,   257,  -123,   152,   270,   276,
     248,   279,   281,     4,     5,   277,     6,     7,   280,   272,
       8,     9,   269,   278,    10,    11,    12,   219,    13,   138,
      14,    15,    16,    17,   201,    18,    19,    20,     0,     0,
      21,     0,     0,     0,    22,    23,    24,    25,    26,    27,
      28,    29,    30,    31,    32,    33,    34,    35,    36,    37,
      38,    97,     0,    98,   236,    99,   100,   101,   102,   103,
     104,   105,   106,   107,   108,   109,   110,   111,   112,   113,
     114,   115,   116,   117,    39,     0,     0,     0,     0,     0,
       0,     0,     0,    40,    41,     0,     0,     0,   193,    42,
      43,    44,     0,    45,    46,     0,    47,     0,    48,     0,
     -44,     4,     5,     0,     6,     7,     0,     0,     8,     9,
       0,     0,    10,    11,    12,     0,    13,     0,    14,    15,
      16,    17,     0,    18,    19,    20,     0,     0,    21,     0,
       0,     0,    22,    23,    24,    25,    26,    27,    28,    29,
      30,    31,    32,    33,    34,    35,    36,    37,    38,    97,
       0,    98,     0,    99,   100,   101,   102,   103,   104,   105,
     106,   107,   108,   109,   110,   111,   112,   113,   114,   115,
     116,   117,    39,     0,     0,     0,     0,     0,     0,     0,
       0,    40,    41,     0,   160,     0,     0,    42,    43,    44,
       0,    45,    46,     0,    47,     0,    48,   161,     4,     5,
       0,     6,     7,     0,     0,     8,     9,     0,     0,    10,
      11,    12,     0,    13,     0,    14,    15,    16,    17,     0,
      18,    19,    20,     0,     0,    21,     0,     0,     0,    22,
      23,    24,    25,    26,    27,    28,    29,    30,    31,    32,
      33,    34,    35,    36,    37,    38,    97,     0,    98,     0,
      99,   100,   101,   102,   103,   104,   105,   106,   107,   108,
     109,   110,   111,   112,   113,   114,   115,   116,   117,    39,
       0,     0,     0,     0,     0,     0,     0,     0,    40,    41,
       0,   194,     0,     0,    42,    43,    44,     0,    45,    46,
       0,    47,     0,    48,   282,     4,     5,     0,     6,     7,
       0,     0,     8,     9,     0,     0,    10,    11,    12,     0,
      13,     0,    14,    15,    16,    17,     0,    18,    19,    20,
       0,     0,    21,     0,     0,     0,    22,    23,    24,    25,
      26,    27,    28,    29,    30,    31,    32,    33,    34,    35,
      36,    37,    38,    97,     0,    98,     0,    99,   100,   101,
     102,   103,   104,   105,   106,   107,   108,   109,   110,   111,
     112,   113,   114,   115,   116,   117,    39,     0,     0,     0,
       0,     0,     0,     0,     0,    40,    41,     0,   202,     0,
       0,    42,    43,    44,     0,    45,    46,     0,    47,     0,
      48,     4,     5,     0,     6,     7,     0,     0,     8,     0,
       0,     0,    10,     0,    91,     0,    13,     0,    14,     0,
      16,    17,     0,     0,    19,     0,     0,     0,    21,     0,
       0,     0,    22,    23,    24,    25,    26,     0,    28,    29,
      30,    31,    32,    33,    34,    97,    36,    98,     0,    99,
     100,   101,   102,   103,   104,   105,   106,   107,   108,   109,
     110,   111,   112,   113,   114,   115,   116,   117,     0,     0,
       0,     0,    39,     0,     0,     0,     0,     0,     0,     0,
     205,    40,    41,     0,     0,     0,     0,    42,    43,    44,
       0,    45,    46,     0,    47,     4,     5,     0,     6,     7,
       0,     0,     8,     0,     0,     0,    10,     0,     0,     0,
      13,     0,    14,     0,    16,    17,     0,     0,    19,     0,
       0,     0,    21,     0,     0,     0,    22,    23,    24,    25,
      26,     0,    28,    29,    30,    31,    32,    33,    34,    97,
      36,    98,     0,    99,   100,   101,   102,   103,   104,   105,
     106,   107,   108,   109,   110,   111,   112,   113,   114,   115,
     116,   117,     0,     0,     0,     0,    39,     0,     0,     0,
       0,     0,     0,     0,   211,    40,    41,     0,     0,     0,
       0,    42,    43,    44,     0,    45,    46,     0,    47,     4,
       5,     0,     6,     7,     0,     0,     8,     0,     0,     0,
      10,     0,     0,     0,   232,     0,    14,     0,    16,    17,
       0,     0,    19,     0,     0,     0,    21,     0,     0,     0,
      22,    23,    24,    25,    26,     0,    28,    29,    30,    31,
      32,    33,    34,    97,    36,    98,     0,    99,   100,   101,
     102,   103,   104,   105,   106,   107,   108,   109,   110,   111,
     112,   113,   114,   115,   116,   117,     0,     0,     0,     0,
      39,     0,     0,     0,     0,     0,     0,     0,   242,    40,
      41,     0,     0,     0,     0,    42,    43,    44,     0,    45,
      46,    97,    47,    98,     0,    99,   100,   101,   102,   103,
     104,   105,   106,   107,   108,   109,   110,   111,   112,   113,
     114,   115,   116,   117,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,    97,   264,    98,   231,    99,
     100,   101,   102,   103,   104,   105,   106,   107,   108,   109,
     110,   111,   112,   113,   114,   115,   116,   117,    97,     0,
      98,     0,    99,   100,   101,   102,   103,   104,   105,   106,
     107,   108,   109,   110,   111,   112,   113,   114,   115,   116,
     117,   215,     0,    98,     0,    99,   100,   101,   102,   103,
     104,   105,   106,   107,   108,   109,   110,   111,   112,   113,
     114,   115,   116,   117,    98,     0,    99,   100,   101,   102,
     103,   104,   105,   106,   107,   108,   109,   110,   111,   112,
     113,   114,   115,   116,   117,   100,   101,   102,   103,   104,
     105,   106,   107,   108,   109,   110,   111,   112,   113,   114,
     115,   116,   117,   101,   102,   103,   104,   105,   106,   107,
     108,   109,   110,   111,   112,   113,   114,   115,   116,   117,
     102,   103,   104,   105,   106,   107,   108,   109,   110,   111,
     112,   113,   114,   115,   116,   117,   103,   104,   105,   106,
     107,   108,   109,   110,   111,   112,   113,   114,   115,   116,
     117,   104,   105,   106,   107,   108,   109,   110,   111,   112,
     113,   114,   115,   116,   117,  -124,  -124,   106,   107,   108,
     109,   110,   111,   112,   113,   114,   115,   116,   117
};

static const yytype_int16 yycheck[] =
{
      48,     9,    17,    11,    40,    41,    42,    43,    14,    19,
      67,    47,    18,    67,    87,    88,    89,   196,    67,    27,
     199,    31,    58,   202,    68,    68,    62,    39,    64,     0,
      66,    67,   211,    45,    46,    27,    72,    73,    74,    31,
     103,    77,    78,    79,    80,   102,    82,    19,   102,   103,
      94,    95,   101,    65,    97,    27,    68,    65,   102,    31,
     239,    97,   103,    99,   100,   101,   102,   103,   104,   105,
     106,   107,   108,   109,   110,   111,   112,   113,   257,   115,
     116,   117,   118,   119,   120,   121,    68,    19,    27,   104,
      97,    23,    31,    97,   100,    27,    14,    66,    67,    31,
      18,    97,    97,    97,    73,    74,   105,    97,    97,    78,
      79,    97,    94,    95,    97,     4,     5,    97,     7,     8,
      97,    97,    97,   159,    97,    19,    15,    97,   164,     4,
       5,    29,     7,     8,   101,    97,    11,    97,    97,   102,
      15,    19,    70,   101,    19,   101,    21,   101,    23,    24,
     119,   120,    27,   189,   102,    19,    31,   104,    67,   101,
      35,    36,    37,    38,    39,   213,    41,    42,    43,    44,
      45,    46,    47,   209,    49,   102,   102,   102,   102,   215,
      84,    85,    86,    87,    88,    89,   105,   195,    78,    79,
      80,    81,    82,    83,    84,    85,    86,    87,    88,    89,
      75,   102,   102,   102,    20,   102,   102,   243,   244,    84,
      85,   103,    99,   101,   262,    90,    91,    92,   102,    94,
      95,   104,    97,    17,    67,   102,   102,   102,    70,   102,
     238,    70,   280,     4,     5,    17,     7,     8,    99,   262,
      11,    12,   258,   267,    15,    16,    17,   190,    19,    63,
      21,    22,    23,    24,   145,    26,    27,    28,    -1,    -1,
      31,    -1,    -1,    -1,    35,    36,    37,    38,    39,    40,
      41,    42,    43,    44,    45,    46,    47,    48,    49,    50,
      51,    67,    -1,    69,   221,    71,    72,    73,    74,    75,
      76,    77,    78,    79,    80,    81,    82,    83,    84,    85,
      86,    87,    88,    89,    75,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,    84,    85,    -1,    -1,    -1,   104,    90,
      91,    92,    -1,    94,    95,    -1,    97,    -1,    99,    -1,
     101,     4,     5,    -1,     7,     8,    -1,    -1,    11,    12,
      -1,    -1,    15,    16,    17,    -1,    19,    -1,    21,    22,
      23,    24,    -1,    26,    27,    28,    -1,    -1,    31,    -1,
      -1,    -1,    35,    36,    37,    38,    39,    40,    41,    42,
      43,    44,    45,    46,    47,    48,    49,    50,    51,    67,
      -1,    69,    -1,    71,    72,    73,    74,    75,    76,    77,
      78,    79,    80,    81,    82,    83,    84,    85,    86,    87,
      88,    89,    75,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,    84,    85,    -1,   102,    -1,    -1,    90,    91,    92,
      -1,    94,    95,    -1,    97,    -1,    99,   100,     4,     5,
      -1,     7,     8,    -1,    -1,    11,    12,    -1,    -1,    15,
      16,    17,    -1,    19,    -1,    21,    22,    23,    24,    -1,
      26,    27,    28,    -1,    -1,    31,    -1,    -1,    -1,    35,
      36,    37,    38,    39,    40,    41,    42,    43,    44,    45,
      46,    47,    48,    49,    50,    51,    67,    -1,    69,    -1,
      71,    72,    73,    74,    75,    76,    77,    78,    79,    80,
      81,    82,    83,    84,    85,    86,    87,    88,    89,    75,
      -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    84,    85,
      -1,   102,    -1,    -1,    90,    91,    92,    -1,    94,    95,
      -1,    97,    -1,    99,   100,     4,     5,    -1,     7,     8,
      -1,    -1,    11,    12,    -1,    -1,    15,    16,    17,    -1,
      19,    -1,    21,    22,    23,    24,    -1,    26,    27,    28,
      -1,    -1,    31,    -1,    -1,    -1,    35,    36,    37,    38,
      39,    40,    41,    42,    43,    44,    45,    46,    47,    48,
      49,    50,    51,    67,    -1,    69,    -1,    71,    72,    73,
      74,    75,    76,    77,    78,    79,    80,    81,    82,    83,
      84,    85,    86,    87,    88,    89,    75,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    84,    85,    -1,   102,    -1,
      -1,    90,    91,    92,    -1,    94,    95,    -1,    97,    -1,
      99,     4,     5,    -1,     7,     8,    -1,    -1,    11,    -1,
      -1,    -1,    15,    -1,    17,    -1,    19,    -1,    21,    -1,
      23,    24,    -1,    -1,    27,    -1,    -1,    -1,    31,    -1,
      -1,    -1,    35,    36,    37,    38,    39,    -1,    41,    42,
      43,    44,    45,    46,    47,    67,    49,    69,    -1,    71,
      72,    73,    74,    75,    76,    77,    78,    79,    80,    81,
      82,    83,    84,    85,    86,    87,    88,    89,    -1,    -1,
      -1,    -1,    75,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
     102,    84,    85,    -1,    -1,    -1,    -1,    90,    91,    92,
      -1,    94,    95,    -1,    97,     4,     5,    -1,     7,     8,
      -1,    -1,    11,    -1,    -1,    -1,    15,    -1,    -1,    -1,
      19,    -1,    21,    -1,    23,    24,    -1,    -1,    27,    -1,
      -1,    -1,    31,    -1,    -1,    -1,    35,    36,    37,    38,
      39,    -1,    41,    42,    43,    44,    45,    46,    47,    67,
      49,    69,    -1,    71,    72,    73,    74,    75,    76,    77,
      78,    79,    80,    81,    82,    83,    84,    85,    86,    87,
      88,    89,    -1,    -1,    -1,    -1,    75,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,   102,    84,    85,    -1,    -1,    -1,
      -1,    90,    91,    92,    -1,    94,    95,    -1,    97,     4,
       5,    -1,     7,     8,    -1,    -1,    11,    -1,    -1,    -1,
      15,    -1,    -1,    -1,    19,    -1,    21,    -1,    23,    24,
      -1,    -1,    27,    -1,    -1,    -1,    31,    -1,    -1,    -1,
      35,    36,    37,    38,    39,    -1,    41,    42,    43,    44,
      45,    46,    47,    67,    49,    69,    -1,    71,    72,    73,
      74,    75,    76,    77,    78,    79,    80,    81,    82,    83,
      84,    85,    86,    87,    88,    89,    -1,    -1,    -1,    -1,
      75,    -1,    -1,    -1,    -1,    -1,    -1,    -1,   102,    84,
      85,    -1,    -1,    -1,    -1,    90,    91,    92,    -1,    94,
      95,    67,    97,    69,    -1,    71,    72,    73,    74,    75,
      76,    77,    78,    79,    80,    81,    82,    83,    84,    85,
      86,    87,    88,    89,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    67,   102,    69,    70,    71,
      72,    73,    74,    75,    76,    77,    78,    79,    80,    81,
      82,    83,    84,    85,    86,    87,    88,    89,    67,    -1,
      69,    -1,    71,    72,    73,    74,    75,    76,    77,    78,
      79,    80,    81,    82,    83,    84,    85,    86,    87,    88,
      89,    67,    -1,    69,    -1,    71,    72,    73,    74,    75,
      76,    77,    78,    79,    80,    81,    82,    83,    84,    85,
      86,    87,    88,    89,    69,    -1,    71,    72,    73,    74,
      75,    76,    77,    78,    79,    80,    81,    82,    83,    84,
      85,    86,    87,    88,    89,    72,    73,    74,    75,    76,
      77,    78,    79,    80,    81,    82,    83,    84,    85,    86,
      87,    88,    89,    73,    74,    75,    76,    77,    78,    79,
      80,    81,    82,    83,    84,    85,    86,    87,    88,    89,
      74,    75,    76,    77,    78,    79,    80,    81,    82,    83,
      84,    85,    86,    87,    88,    89,    75,    76,    77,    78,
      79,    80,    81,    82,    83,    84,    85,    86,    87,    88,
      89,    76,    77,    78,    79,    80,    81,    82,    83,    84,
      85,    86,    87,    88,    89,    76,    77,    78,    79,    80,
      81,    82,    83,    84,    85,    86,    87,    88,    89
};

  /* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
     symbol of state STATE-NUM.  */
static const yytype_uint8 yystos[] =
{
       0,   107,   111,     0,     4,     5,     7,     8,    11,    12,
      15,    16,    17,    19,    21,    22,    23,    24,    26,    27,
      28,    31,    35,    36,    37,    38,    39,    40,    41,    42,
      43,    44,    45,    46,    47,    48,    49,    50,    51,    75,
      84,    85,    90,    91,    92,    94,    95,    97,    99,   108,
     112,   125,   126,   129,   130,   131,   132,   133,   103,   125,
     125,   113,   103,   135,    97,    97,    97,    97,    97,   105,
     142,   143,    97,    97,    97,    97,   125,    97,    97,    97,
      97,    97,    97,   133,   126,   126,   126,   126,    19,   133,
     133,    17,   126,   111,    29,   109,   101,    67,    69,    71,
      72,    73,    74,    75,    76,    77,    78,    79,    80,    81,
      82,    83,    84,    85,    86,    87,    88,    89,    97,    97,
      97,    68,    94,    95,   144,   126,   136,   137,   101,   101,
      19,    23,    27,    31,   119,   120,   122,   126,   142,   126,
     125,   133,   136,   136,   133,    27,    31,   126,   136,   136,
     102,   101,   102,   126,   136,   136,   126,    19,   126,   102,
     102,   100,    70,   126,   127,   126,   126,   126,   126,   126,
     126,   126,   126,   126,   126,   126,   126,   126,   126,   126,
      19,   126,   126,   126,   126,   136,   136,   126,   104,    67,
      67,   101,   121,   104,   102,   101,   102,   102,   102,   102,
     105,   143,   102,   102,   102,   102,   102,   102,   114,    67,
     102,   102,   126,   110,   126,    67,   102,   102,   126,   120,
     103,   134,   125,   112,   112,    27,   112,   102,   126,   112,
     111,    70,    19,    17,   104,    97,   144,   145,   101,    20,
     124,    99,   102,   128,    67,   102,   104,   146,   125,   112,
     115,   126,   126,    17,   138,   139,   140,   102,    14,    18,
     100,   116,   117,   118,   102,   141,   147,    67,   112,   130,
      70,   111,   118,    19,    31,   123,   102,    17,   140,    70,
      99,   111,   100
};

  /* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const yytype_uint8 yyr1[] =
{
       0,   106,   107,   108,   108,   110,   109,   111,   111,   112,
     112,   113,   112,   112,   112,   112,   112,   112,   112,   112,
     114,   112,   112,   112,   112,   115,   115,   116,   117,   117,
     118,   118,   119,   119,   121,   120,   122,   122,   122,   122,
     123,   123,   124,   124,   125,   125,   126,   126,   126,   126,
     126,   126,   126,   126,   126,   126,   126,   126,   126,   126,
     126,   126,   126,   126,   126,   126,   126,   127,   128,   126,
     126,   126,   126,   126,   126,   126,   126,   126,   126,   126,
     126,   126,   126,   126,   126,   126,   126,   126,   126,   126,
     126,   126,   126,   126,   126,   126,   126,   126,   129,   129,
     130,   130,   130,   130,   130,   131,   131,   131,   132,   132,
     133,   133,   133,   134,   134,   134,   135,   135,   136,   136,
     137,   137,   138,   138,   138,   139,   139,   141,   140,   142,
     142,   142,   143,   143,   144,   144,   145,   146,   147,   145
};

  /* YYR2[YYN] -- Number of symbols on the right hand side of rule YYN.  */
static const yytype_int8 yyr2[] =
{
       0,     2,     2,     0,     2,     0,     4,     0,     2,     3,
       2,     0,     4,     6,     5,     9,     5,     4,     6,     5,
       0,     8,     3,     3,     3,     0,     2,     2,     1,     2,
       3,     2,     1,     3,     0,     4,     1,     1,     1,     1,
       1,     1,     0,     2,     0,     1,     3,     4,     3,     3,
       3,     3,     3,     3,     3,     3,     3,     3,     3,     3,
       3,     3,     3,     3,     3,     3,     3,     0,     0,     7,
       2,     2,     2,     2,     2,     2,     4,     4,     4,     4,
       4,     6,     8,     4,     3,     3,     4,     4,     4,     4,
       4,     2,     2,     2,     3,     2,     2,     1,     1,     1,
       1,     1,     1,     1,     1,     1,     1,     1,     1,     1,
       2,     3,     1,     0,     2,     3,     0,     3,     0,     1,
       1,     3,     0,     1,     1,     1,     3,     0,     3,     0,
       1,     3,     2,     2,     0,     2,     1,     0,     0,     8
};


#define yyerrok         (yyerrstatus = 0)
#define yyclearin       (yychar = YYEMPTY)
#define YYEMPTY         (-2)
#define YYEOF           0

#define YYACCEPT        goto yyacceptlab
#define YYABORT         goto yyabortlab
#define YYERROR         goto yyerrorlab


#define YYRECOVERING()  (!!yyerrstatus)

#define YYBACKUP(Token, Value)                                    \
  do                                                              \
    if (yychar == YYEMPTY)                                        \
      {                                                           \
        yychar = (Token);                                         \
        yylval = (Value);                                         \
        YYPOPSTACK (yylen);                                       \
        yystate = *yyssp;                                         \
        goto yybackup;                                            \
      }                                                           \
    else                                                          \
      {                                                           \
        yyerror (YY_("syntax error: cannot back up")); \
        YYERROR;                                                  \
      }                                                           \
  while (0)

/* Error token number */
#define YYTERROR        1
#define YYERRCODE       256



/* Enable debugging if requested.  */
#if EX_DEBUG

# ifndef YYFPRINTF
#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
#  define YYFPRINTF fprintf
# endif

# define YYDPRINTF(Args)                        \
do {                                            \
  if (yydebug)                                  \
    YYFPRINTF Args;                             \
} while (0)

/* This macro is provided for backward compatibility. */
#ifndef YY_LOCATION_PRINT
# define YY_LOCATION_PRINT(File, Loc) ((void) 0)
#endif


# define YY_SYMBOL_PRINT(Title, Type, Value, Location)                    \
do {                                                                      \
  if (yydebug)                                                            \
    {                                                                     \
      YYFPRINTF (stderr, "%s ", Title);                                   \
      yy_symbol_print (stderr,                                            \
                  Type, Value); \
      YYFPRINTF (stderr, "\n");                                           \
    }                                                                     \
} while (0)


/*-----------------------------------.
| Print this symbol's value on YYO.  |
`-----------------------------------*/

static void
yy_symbol_value_print (FILE *yyo, int yytype, YYSTYPE const * const yyvaluep)
{
  FILE *yyoutput = yyo;
  YYUSE (yyoutput);
  if (!yyvaluep)
    return;
# ifdef YYPRINT
  if (yytype < YYNTOKENS)
    YYPRINT (yyo, yytoknum[yytype], *yyvaluep);
# endif
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YYUSE (yytype);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}


/*---------------------------.
| Print this symbol on YYO.  |
`---------------------------*/

static void
yy_symbol_print (FILE *yyo, int yytype, YYSTYPE const * const yyvaluep)
{
  YYFPRINTF (yyo, "%s %s (",
             yytype < YYNTOKENS ? "token" : "nterm", yytname[yytype]);

  yy_symbol_value_print (yyo, yytype, yyvaluep);
  YYFPRINTF (yyo, ")");
}

/*------------------------------------------------------------------.
| yy_stack_print -- Print the state stack from its BOTTOM up to its |
| TOP (included).                                                   |
`------------------------------------------------------------------*/

static void
yy_stack_print (yy_state_t *yybottom, yy_state_t *yytop)
{
  YYFPRINTF (stderr, "Stack now");
  for (; yybottom <= yytop; yybottom++)
    {
      int yybot = *yybottom;
      YYFPRINTF (stderr, " %d", yybot);
    }
  YYFPRINTF (stderr, "\n");
}

# define YY_STACK_PRINT(Bottom, Top)                            \
do {                                                            \
  if (yydebug)                                                  \
    yy_stack_print ((Bottom), (Top));                           \
} while (0)


/*------------------------------------------------.
| Report that the YYRULE is going to be reduced.  |
`------------------------------------------------*/

static void
yy_reduce_print (yy_state_t *yyssp, YYSTYPE *yyvsp, int yyrule)
{
  int yylno = yyrline[yyrule];
  int yynrhs = yyr2[yyrule];
  int yyi;
  YYFPRINTF (stderr, "Reducing stack by rule %d (line %d):\n",
             yyrule - 1, yylno);
  /* The symbols being reduced.  */
  for (yyi = 0; yyi < yynrhs; yyi++)
    {
      YYFPRINTF (stderr, "   $%d = ", yyi + 1);
      yy_symbol_print (stderr,
                       yystos[+yyssp[yyi + 1 - yynrhs]],
                       &yyvsp[(yyi + 1) - (yynrhs)]
                                              );
      YYFPRINTF (stderr, "\n");
    }
}

# define YY_REDUCE_PRINT(Rule)          \
do {                                    \
  if (yydebug)                          \
    yy_reduce_print (yyssp, yyvsp, Rule); \
} while (0)

/* Nonzero means print parse trace.  It is left uninitialized so that
   multiple parsers can coexist.  */
int yydebug;
#else /* !EX_DEBUG */
# define YYDPRINTF(Args)
# define YY_SYMBOL_PRINT(Title, Type, Value, Location)
# define YY_STACK_PRINT(Bottom, Top)
# define YY_REDUCE_PRINT(Rule)
#endif /* !EX_DEBUG */


/* YYINITDEPTH -- initial size of the parser's stacks.  */
#ifndef YYINITDEPTH
# define YYINITDEPTH 200
#endif

/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
   if the built-in stack extension method is used).

   Do not make this value too large; the results are undefined if
   YYSTACK_ALLOC_MAXIMUM < YYSTACK_BYTES (YYMAXDEPTH)
   evaluated with infinite-precision integer arithmetic.  */

#ifndef YYMAXDEPTH
# define YYMAXDEPTH 10000
#endif


#if YYERROR_VERBOSE

# ifndef yystrlen
#  if defined __GLIBC__ && defined _STRING_H
#   define yystrlen(S) (YY_CAST (YYPTRDIFF_T, strlen (S)))
#  else
/* Return the length of YYSTR.  */
static YYPTRDIFF_T
yystrlen (const char *yystr)
{
  YYPTRDIFF_T yylen;
  for (yylen = 0; yystr[yylen]; yylen++)
    continue;
  return yylen;
}
#  endif
# endif

# ifndef yystpcpy
#  if defined __GLIBC__ && defined _STRING_H && defined _GNU_SOURCE
#   define yystpcpy stpcpy
#  else
/* Copy YYSRC to YYDEST, returning the address of the terminating '\0' in
   YYDEST.  */
static char *
yystpcpy (char *yydest, const char *yysrc)
{
  char *yyd = yydest;
  const char *yys = yysrc;

  while ((*yyd++ = *yys++) != '\0')
    continue;

  return yyd - 1;
}
#  endif
# endif

# ifndef yytnamerr
/* Copy to YYRES the contents of YYSTR after stripping away unnecessary
   quotes and backslashes, so that it's suitable for yyerror.  The
   heuristic is that double-quoting is unnecessary unless the string
   contains an apostrophe, a comma, or backslash (other than
   backslash-backslash).  YYSTR is taken from yytname.  If YYRES is
   null, do not copy; instead, return the length of what the result
   would have been.  */
static YYPTRDIFF_T
yytnamerr (char *yyres, const char *yystr)
{
  if (*yystr == '"')
    {
      YYPTRDIFF_T yyn = 0;
      char const *yyp = yystr;

      for (;;)
        switch (*++yyp)
          {
          case '\'':
          case ',':
            goto do_not_strip_quotes;

          case '\\':
            if (*++yyp != '\\')
              goto do_not_strip_quotes;
            else
              goto append;

          append:
          default:
            if (yyres)
              yyres[yyn] = *yyp;
            yyn++;
            break;

          case '"':
            if (yyres)
              yyres[yyn] = '\0';
            return yyn;
          }
    do_not_strip_quotes: ;
    }

  if (yyres)
    return yystpcpy (yyres, yystr) - yyres;
  else
    return yystrlen (yystr);
}
# endif

/* Copy into *YYMSG, which is of size *YYMSG_ALLOC, an error message
   about the unexpected token YYTOKEN for the state stack whose top is
   YYSSP.

   Return 0 if *YYMSG was successfully written.  Return 1 if *YYMSG is
   not large enough to hold the message.  In that case, also set
   *YYMSG_ALLOC to the required number of bytes.  Return 2 if the
   required number of bytes is too large to store.  */
static int
yysyntax_error (YYPTRDIFF_T *yymsg_alloc, char **yymsg,
                yy_state_t *yyssp, int yytoken)
{
  enum { YYERROR_VERBOSE_ARGS_MAXIMUM = 5 };
  /* Internationalized format string. */
  const char *yyformat = YY_NULLPTR;
  /* Arguments of yyformat: reported tokens (one for the "unexpected",
     one per "expected"). */
  char const *yyarg[YYERROR_VERBOSE_ARGS_MAXIMUM];
  /* Actual size of YYARG. */
  int yycount = 0;
  /* Cumulated lengths of YYARG.  */
  YYPTRDIFF_T yysize = 0;

  /* There are many possibilities here to consider:
     - If this state is a consistent state with a default action, then
       the only way this function was invoked is if the default action
       is an error action.  In that case, don't check for expected
       tokens because there are none.
     - The only way there can be no lookahead present (in yychar) is if
       this state is a consistent state with a default action.  Thus,
       detecting the absence of a lookahead is sufficient to determine
       that there is no unexpected or expected token to report.  In that
       case, just report a simple "syntax error".
     - Don't assume there isn't a lookahead just because this state is a
       consistent state with a default action.  There might have been a
       previous inconsistent state, consistent state with a non-default
       action, or user semantic action that manipulated yychar.
     - Of course, the expected token list depends on states to have
       correct lookahead information, and it depends on the parser not
       to perform extra reductions after fetching a lookahead from the
       scanner and before detecting a syntax error.  Thus, state merging
       (from LALR or IELR) and default reductions corrupt the expected
       token list.  However, the list is correct for canonical LR with
       one exception: it will still contain any token that will not be
       accepted due to an error action in a later state.
  */
  if (yytoken != YYEMPTY)
    {
      int yyn = yypact[+*yyssp];
      YYPTRDIFF_T yysize0 = yytnamerr (YY_NULLPTR, yytname[yytoken]);
      yysize = yysize0;
      yyarg[yycount++] = yytname[yytoken];
      if (!yypact_value_is_default (yyn))
        {
          /* Start YYX at -YYN if negative to avoid negative indexes in
             YYCHECK.  In other words, skip the first -YYN actions for
             this state because they are default actions.  */
          int yyxbegin = yyn < 0 ? -yyn : 0;
          /* Stay within bounds of both yycheck and yytname.  */
          int yychecklim = YYLAST - yyn + 1;
          int yyxend = yychecklim < YYNTOKENS ? yychecklim : YYNTOKENS;
          int yyx;

          for (yyx = yyxbegin; yyx < yyxend; ++yyx)
            if (yycheck[yyx + yyn] == yyx && yyx != YYTERROR
                && !yytable_value_is_error (yytable[yyx + yyn]))
              {
                if (yycount == YYERROR_VERBOSE_ARGS_MAXIMUM)
                  {
                    yycount = 1;
                    yysize = yysize0;
                    break;
                  }
                yyarg[yycount++] = yytname[yyx];
                {
                  YYPTRDIFF_T yysize1
                    = yysize + yytnamerr (YY_NULLPTR, yytname[yyx]);
                  if (yysize <= yysize1 && yysize1 <= YYSTACK_ALLOC_MAXIMUM)
                    yysize = yysize1;
                  else
                    return 2;
                }
              }
        }
    }

  switch (yycount)
    {
# define YYCASE_(N, S)                      \
      case N:                               \
        yyformat = S;                       \
      break
    default: /* Avoid compiler warnings. */
      YYCASE_(0, YY_("syntax error"));
      YYCASE_(1, YY_("syntax error, unexpected %s"));
      YYCASE_(2, YY_("syntax error, unexpected %s, expecting %s"));
      YYCASE_(3, YY_("syntax error, unexpected %s, expecting %s or %s"));
      YYCASE_(4, YY_("syntax error, unexpected %s, expecting %s or %s or %s"));
      YYCASE_(5, YY_("syntax error, unexpected %s, expecting %s or %s or %s or %s"));
# undef YYCASE_
    }

  {
    /* Don't count the "%s"s in the final size, but reserve room for
       the terminator.  */
    YYPTRDIFF_T yysize1 = yysize + (yystrlen (yyformat) - 2 * yycount) + 1;
    if (yysize <= yysize1 && yysize1 <= YYSTACK_ALLOC_MAXIMUM)
      yysize = yysize1;
    else
      return 2;
  }

  if (*yymsg_alloc < yysize)
    {
      *yymsg_alloc = 2 * yysize;
      if (! (yysize <= *yymsg_alloc
             && *yymsg_alloc <= YYSTACK_ALLOC_MAXIMUM))
        *yymsg_alloc = YYSTACK_ALLOC_MAXIMUM;
      return 1;
    }

  /* Avoid sprintf, as that infringes on the user's name space.
     Don't have undefined behavior even if the translation
     produced a string with the wrong number of "%s"s.  */
  {
    char *yyp = *yymsg;
    int yyi = 0;
    while ((*yyp = *yyformat) != '\0')
      if (*yyp == '%' && yyformat[1] == 's' && yyi < yycount)
        {
          yyp += yytnamerr (yyp, yyarg[yyi++]);
          yyformat += 2;
        }
      else
        {
          ++yyp;
          ++yyformat;
        }
  }
  return 0;
}
#endif /* YYERROR_VERBOSE */

/*-----------------------------------------------.
| Release the memory associated to this symbol.  |
`-----------------------------------------------*/

static void
yydestruct (const char *yymsg, int yytype, YYSTYPE *yyvaluep)
{
  YYUSE (yyvaluep);
  if (!yymsg)
    yymsg = "Deleting";
  YY_SYMBOL_PRINT (yymsg, yytype, yyvaluep, yylocationp);

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YYUSE (yytype);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}




/* The lookahead symbol.  */
int yychar;

/* The semantic value of the lookahead symbol.  */
YYSTYPE yylval;
/* Number of syntax errors so far.  */
int yynerrs;


/*----------.
| yyparse.  |
`----------*/

int
yyparse (void)
{
    yy_state_fast_t yystate;
    /* Number of tokens to shift before error messages enabled.  */
    int yyerrstatus;

    /* The stacks and their tools:
       'yyss': related to states.
       'yyvs': related to semantic values.

       Refer to the stacks through separate pointers, to allow yyoverflow
       to reallocate them elsewhere.  */

    /* The state stack.  */
    yy_state_t yyssa[YYINITDEPTH];
    yy_state_t *yyss;
    yy_state_t *yyssp;

    /* The semantic value stack.  */
    YYSTYPE yyvsa[YYINITDEPTH];
    YYSTYPE *yyvs;
    YYSTYPE *yyvsp;

    YYPTRDIFF_T yystacksize;

  int yyn;
  int yyresult;
  /* Lookahead token as an internal (translated) token number.  */
  int yytoken = 0;
  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;

#if YYERROR_VERBOSE
  /* Buffer for error messages, and its allocated size.  */
  char yymsgbuf[128];
  char *yymsg = yymsgbuf;
  YYPTRDIFF_T yymsg_alloc = sizeof yymsgbuf;
#endif

#define YYPOPSTACK(N)   (yyvsp -= (N), yyssp -= (N))

  /* The number of symbols on the RHS of the reduced rule.
     Keep to zero when no symbol should be popped.  */
  int yylen = 0;

  yyssp = yyss = yyssa;
  yyvsp = yyvs = yyvsa;
  yystacksize = YYINITDEPTH;

  YYDPRINTF ((stderr, "Starting parse\n"));

  yystate = 0;
  yyerrstatus = 0;
  yynerrs = 0;
  yychar = YYEMPTY; /* Cause a token to be read.  */
  goto yysetstate;


/*------------------------------------------------------------.
| yynewstate -- push a new state, which is found in yystate.  |
`------------------------------------------------------------*/
yynewstate:
  /* In all cases, when you get here, the value and location stacks
     have just been pushed.  So pushing a state here evens the stacks.  */
  yyssp++;


/*--------------------------------------------------------------------.
| yysetstate -- set current state (the top of the stack) to yystate.  |
`--------------------------------------------------------------------*/
yysetstate:
  YYDPRINTF ((stderr, "Entering state %d\n", yystate));
  YY_ASSERT (0 <= yystate && yystate < YYNSTATES);
  YY_IGNORE_USELESS_CAST_BEGIN
  *yyssp = YY_CAST (yy_state_t, yystate);
  YY_IGNORE_USELESS_CAST_END

  if (yyss + yystacksize - 1 <= yyssp)
#if !defined yyoverflow && !defined YYSTACK_RELOCATE
    goto yyexhaustedlab;
#else
    {
      /* Get the current used size of the three stacks, in elements.  */
      YYPTRDIFF_T yysize = yyssp - yyss + 1;

# if defined yyoverflow
      {
        /* Give user a chance to reallocate the stack.  Use copies of
           these so that the &'s don't force the real ones into
           memory.  */
        yy_state_t *yyss1 = yyss;
        YYSTYPE *yyvs1 = yyvs;

        /* Each stack pointer address is followed by the size of the
           data in use in that stack, in bytes.  This used to be a
           conditional around just the two extra args, but that might
           be undefined if yyoverflow is a macro.  */
        yyoverflow (YY_("memory exhausted"),
                    &yyss1, yysize * YYSIZEOF (*yyssp),
                    &yyvs1, yysize * YYSIZEOF (*yyvsp),
                    &yystacksize);
        yyss = yyss1;
        yyvs = yyvs1;
      }
# else /* defined YYSTACK_RELOCATE */
      /* Extend the stack our own way.  */
      if (YYMAXDEPTH <= yystacksize)
        goto yyexhaustedlab;
      yystacksize *= 2;
      if (YYMAXDEPTH < yystacksize)
        yystacksize = YYMAXDEPTH;

      {
        yy_state_t *yyss1 = yyss;
        union yyalloc *yyptr =
          YY_CAST (union yyalloc *,
                   YYSTACK_ALLOC (YY_CAST (YYSIZE_T, YYSTACK_BYTES (yystacksize))));
        if (! yyptr)
          goto yyexhaustedlab;
        YYSTACK_RELOCATE (yyss_alloc, yyss);
        YYSTACK_RELOCATE (yyvs_alloc, yyvs);
# undef YYSTACK_RELOCATE
        if (yyss1 != yyssa)
          YYSTACK_FREE (yyss1);
      }
# endif

      yyssp = yyss + yysize - 1;
      yyvsp = yyvs + yysize - 1;

      YY_IGNORE_USELESS_CAST_BEGIN
      YYDPRINTF ((stderr, "Stack size increased to %ld\n",
                  YY_CAST (long, yystacksize)));
      YY_IGNORE_USELESS_CAST_END

      if (yyss + yystacksize - 1 <= yyssp)
        YYABORT;
    }
#endif /* !defined yyoverflow && !defined YYSTACK_RELOCATE */

  if (yystate == YYFINAL)
    YYACCEPT;

  goto yybackup;


/*-----------.
| yybackup.  |
`-----------*/
yybackup:
  /* Do appropriate processing given the current state.  Read a
     lookahead token if we need one and don't already have one.  */

  /* First try to decide what to do without reference to lookahead token.  */
  yyn = yypact[yystate];
  if (yypact_value_is_default (yyn))
    goto yydefault;

  /* Not known => get a lookahead token if don't already have one.  */

  /* YYCHAR is either YYEMPTY or YYEOF or a valid lookahead symbol.  */
  if (yychar == YYEMPTY)
    {
      YYDPRINTF ((stderr, "Reading a token: "));
      yychar = yylex ();
    }

  if (yychar <= YYEOF)
    {
      yychar = yytoken = YYEOF;
      YYDPRINTF ((stderr, "Now at end of input.\n"));
    }
  else
    {
      yytoken = YYTRANSLATE (yychar);
      YY_SYMBOL_PRINT ("Next token is", yytoken, &yylval, &yylloc);
    }

  /* If the proper action on seeing token YYTOKEN is to reduce or to
     detect an error, take that action.  */
  yyn += yytoken;
  if (yyn < 0 || YYLAST < yyn || yycheck[yyn] != yytoken)
    goto yydefault;
  yyn = yytable[yyn];
  if (yyn <= 0)
    {
      if (yytable_value_is_error (yyn))
        goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }

  /* Count tokens shifted since error; after three, turn off error
     status.  */
  if (yyerrstatus)
    yyerrstatus--;

  /* Shift the lookahead token.  */
  YY_SYMBOL_PRINT ("Shifting", yytoken, &yylval, &yylloc);
  yystate = yyn;
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END

  /* Discard the shifted token.  */
  yychar = YYEMPTY;
  goto yynewstate;


/*-----------------------------------------------------------.
| yydefault -- do the default action for the current state.  |
`-----------------------------------------------------------*/
yydefault:
  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;
  goto yyreduce;


/*-----------------------------.
| yyreduce -- do a reduction.  |
`-----------------------------*/
yyreduce:
  /* yyn is the number of a rule to reduce with.  */
  yylen = yyr2[yyn];

  /* If YYLEN is nonzero, implement the default value of the action:
     '$$ = $1'.

     Otherwise, the following line sets YYVAL to garbage.
     This behavior is undocumented and Bison
     users should not rely upon it.  Assigning to YYVAL
     unconditionally makes the parser a bit smaller, and it avoids a
     GCC warning that YYVAL may be used uninitialized.  */
  yyval = yyvsp[1-yylen];


  YY_REDUCE_PRINT (yyn);
  switch (yyn)
    {
  case 2:
#line 180 "../../lib/expr/exparse.y"
                {
			if ((yyvsp[-1].expr))	{
				if (expr.program->main.value)
					exfreenode(expr.program, expr.program->main.value);
				if ((yyvsp[-1].expr)->op == S2B)
				{
					Exnode_t*	x;

					x = (yyvsp[-1].expr);
					(yyvsp[-1].expr) = x->data.operand.left;
					x->data.operand.left = 0;
					exfreenode(expr.program, x);
				}
				expr.program->main.lex = PROCEDURE;
				expr.program->main.value = exnewnode(expr.program, PROCEDURE, true, (yyvsp[-1].expr)->type, NULL, (yyvsp[-1].expr));
			}
		}
#line 1906 "exparse.c"
    break;

  case 5:
#line 203 "../../lib/expr/exparse.y"
                                  {
				if (expr.procedure)
					exerror("no nested function definitions");
				(yyvsp[-1].id)->lex = PROCEDURE;
				expr.procedure = (yyvsp[-1].id)->value = exnewnode(expr.program, PROCEDURE, true, (yyvsp[-1].id)->type, NULL, NULL);
				expr.procedure->type = INTEGER;
				static Dtdisc_t disc = {.key = offsetof(Exid_t, name)};
				if (expr.assigned && !streq((yyvsp[-1].id)->name, "begin"))
				{
					if (!(expr.procedure->data.procedure.frame = dtopen(&disc, Dtset)) ||
					    !dtview(expr.procedure->data.procedure.frame, expr.program->symbols))
						exnospace();
					expr.program->symbols = expr.program->frame = expr.procedure->data.procedure.frame;
				}
			}
#line 1926 "exparse.c"
    break;

  case 6:
#line 218 "../../lib/expr/exparse.y"
                {
			expr.procedure = 0;
			if (expr.program->frame)
			{
				expr.program->symbols = expr.program->frame->view;
				dtview(expr.program->frame, NULL);
				expr.program->frame = 0;
			}
			if ((yyvsp[0].expr) && (yyvsp[0].expr)->op == S2B)
			{
				Exnode_t*	x;

				x = (yyvsp[0].expr);
				(yyvsp[0].expr) = x->data.operand.left;
				x->data.operand.left = 0;
				exfreenode(expr.program, x);
			}
			(yyvsp[-3].id)->value->data.operand.right = excast(expr.program, (yyvsp[0].expr), (yyvsp[-3].id)->type, NULL, 0);
		}
#line 1950 "exparse.c"
    break;

  case 7:
#line 240 "../../lib/expr/exparse.y"
                {
			(yyval.expr) = 0;
		}
#line 1958 "exparse.c"
    break;

  case 8:
#line 244 "../../lib/expr/exparse.y"
                {
			if (!(yyvsp[-1].expr))
				(yyval.expr) = (yyvsp[0].expr);
			else if (!(yyvsp[0].expr))
				(yyval.expr) = (yyvsp[-1].expr);
			else if ((yyvsp[-1].expr)->op == CONSTANT)
			{
				exfreenode(expr.program, (yyvsp[-1].expr));
				(yyval.expr) = (yyvsp[0].expr);
			}
			else (yyval.expr) = exnewnode(expr.program, ';', true, (yyvsp[0].expr)->type, (yyvsp[-1].expr), (yyvsp[0].expr));
		}
#line 1975 "exparse.c"
    break;

  case 9:
#line 259 "../../lib/expr/exparse.y"
                {
			(yyval.expr) = (yyvsp[-1].expr);
		}
#line 1983 "exparse.c"
    break;

  case 10:
#line 263 "../../lib/expr/exparse.y"
                {
			(yyval.expr) = ((yyvsp[-1].expr) && (yyvsp[-1].expr)->type == STRING) ? exnewnode(expr.program, S2B, true, INTEGER, (yyvsp[-1].expr), NULL) : (yyvsp[-1].expr);
		}
#line 1991 "exparse.c"
    break;

  case 11:
#line 266 "../../lib/expr/exparse.y"
                                {expr.declare = (yyvsp[0].id)->type;}
#line 1997 "exparse.c"
    break;

  case 12:
#line 267 "../../lib/expr/exparse.y"
                {
			(yyval.expr) = (yyvsp[-1].expr);
			expr.declare = 0;
		}
#line 2006 "exparse.c"
    break;

  case 13:
#line 272 "../../lib/expr/exparse.y"
                {
			if (exisAssign ((yyvsp[-3].expr)))
				exwarn ("assignment used as boolean in if statement");
			if ((yyvsp[-3].expr)->type == STRING)
				(yyvsp[-3].expr) = exnewnode(expr.program, S2B, true, INTEGER, (yyvsp[-3].expr), NULL);
			else if (!INTEGRAL((yyvsp[-3].expr)->type))
				(yyvsp[-3].expr) = excast(expr.program, (yyvsp[-3].expr), INTEGER, NULL, 0);
			(yyval.expr) = exnewnode(expr.program, (yyvsp[-5].id)->index, true, INTEGER, (yyvsp[-3].expr), exnewnode(expr.program, ':', true, (yyvsp[-1].expr) ? (yyvsp[-1].expr)->type : 0, (yyvsp[-1].expr), (yyvsp[0].expr)));
		}
#line 2020 "exparse.c"
    break;

  case 14:
#line 282 "../../lib/expr/exparse.y"
                {
			(yyval.expr) = exnewnode(expr.program, ITERATE, false, INTEGER, NULL, NULL);
			(yyval.expr)->data.generate.array = (yyvsp[-2].expr);
			if (!(yyvsp[-2].expr)->data.variable.index || (yyvsp[-2].expr)->data.variable.index->op != DYNAMIC)
				exerror("simple index variable expected");
			(yyval.expr)->data.generate.index = (yyvsp[-2].expr)->data.variable.index->data.variable.symbol;
			if ((yyvsp[-2].expr)->op == ID && (yyval.expr)->data.generate.index->type != INTEGER)
				exerror("integer index variable expected");
			exfreenode(expr.program, (yyvsp[-2].expr)->data.variable.index);
			(yyvsp[-2].expr)->data.variable.index = 0;
			(yyval.expr)->data.generate.statement = (yyvsp[0].expr);
		}
#line 2037 "exparse.c"
    break;

  case 15:
#line 295 "../../lib/expr/exparse.y"
                {
			if (!(yyvsp[-4].expr))
			{
				(yyvsp[-4].expr) = exnewnode(expr.program, CONSTANT, false, INTEGER, NULL, NULL);
				(yyvsp[-4].expr)->data.constant.value.integer = 1;
			}
			else if ((yyvsp[-4].expr)->type == STRING)
				(yyvsp[-4].expr) = exnewnode(expr.program, S2B, true, INTEGER, (yyvsp[-4].expr), NULL);
			else if (!INTEGRAL((yyvsp[-4].expr)->type))
				(yyvsp[-4].expr) = excast(expr.program, (yyvsp[-4].expr), INTEGER, NULL, 0);
			(yyval.expr) = exnewnode(expr.program, (yyvsp[-8].id)->index, true, INTEGER, (yyvsp[-4].expr), exnewnode(expr.program, ';', 1, 0, (yyvsp[-2].expr), (yyvsp[0].expr)));
			if ((yyvsp[-6].expr))
				(yyval.expr) = exnewnode(expr.program, ';', true, INTEGER, (yyvsp[-6].expr), (yyval.expr));
		}
#line 2056 "exparse.c"
    break;

  case 16:
#line 310 "../../lib/expr/exparse.y"
                {
			(yyval.expr) = exnewnode(expr.program, ITERATOR, false, INTEGER, NULL, NULL);
			(yyval.expr)->data.generate.array = (yyvsp[-2].expr);
			if (!(yyvsp[-2].expr)->data.variable.index || (yyvsp[-2].expr)->data.variable.index->op != DYNAMIC)
				exerror("simple index variable expected");
			(yyval.expr)->data.generate.index = (yyvsp[-2].expr)->data.variable.index->data.variable.symbol;
			if ((yyvsp[-2].expr)->op == ID && (yyval.expr)->data.generate.index->type != INTEGER)
				exerror("integer index variable expected");
			exfreenode(expr.program, (yyvsp[-2].expr)->data.variable.index);
			(yyvsp[-2].expr)->data.variable.index = 0;
			(yyval.expr)->data.generate.statement = (yyvsp[0].expr);
		}
#line 2073 "exparse.c"
    break;

  case 17:
#line 323 "../../lib/expr/exparse.y"
                {
			if ((yyvsp[-1].id)->local == NULL)
              			exerror("cannot apply unset to non-array %s", (yyvsp[-1].id)->name);
			(yyval.expr) = exnewnode(expr.program, UNSET, false, INTEGER, NULL, NULL);
			(yyval.expr)->data.variable.symbol = (yyvsp[-1].id);
			(yyval.expr)->data.variable.index = NULL;
		}
#line 2085 "exparse.c"
    break;

  case 18:
#line 331 "../../lib/expr/exparse.y"
                {
			if ((yyvsp[-3].id)->local == NULL)
              			exerror("cannot apply unset to non-array %s", (yyvsp[-3].id)->name);
			if (((yyvsp[-3].id)->index_type > 0) && ((yyvsp[-1].expr)->type != (yyvsp[-3].id)->index_type))
            		    exerror("%s indices must have type %s, not %s", 
				(yyvsp[-3].id)->name, extypename(expr.program, (yyvsp[-3].id)->index_type),extypename(expr.program, (yyvsp[-1].expr)->type));
			(yyval.expr) = exnewnode(expr.program, UNSET, false, INTEGER, NULL, NULL);
			(yyval.expr)->data.variable.symbol = (yyvsp[-3].id);
			(yyval.expr)->data.variable.index = (yyvsp[-1].expr);
		}
#line 2100 "exparse.c"
    break;

  case 19:
#line 342 "../../lib/expr/exparse.y"
                {
			if (exisAssign ((yyvsp[-2].expr)))
				exwarn ("assignment used as boolean in while statement");
			if ((yyvsp[-2].expr)->type == STRING)
				(yyvsp[-2].expr) = exnewnode(expr.program, S2B, true, INTEGER, (yyvsp[-2].expr), NULL);
			else if (!INTEGRAL((yyvsp[-2].expr)->type))
				(yyvsp[-2].expr) = excast(expr.program, (yyvsp[-2].expr), INTEGER, NULL, 0);
			(yyval.expr) = exnewnode(expr.program, (yyvsp[-4].id)->index, true, INTEGER, (yyvsp[-2].expr), exnewnode(expr.program, ';', true, 0, NULL, (yyvsp[0].expr)));
		}
#line 2114 "exparse.c"
    break;

  case 20:
#line 351 "../../lib/expr/exparse.y"
                                        {expr.declare=(yyvsp[0].expr)->type;}
#line 2120 "exparse.c"
    break;

  case 21:
#line 352 "../../lib/expr/exparse.y"
                {
			Switch_t*	sw = expr.swstate;

			(yyval.expr) = exnewnode(expr.program, (yyvsp[-7].id)->index, true, INTEGER, (yyvsp[-5].expr), exnewnode(expr.program, DEFAULT, true, 0, sw->defcase, sw->firstcase));
			expr.swstate = expr.swstate->prev;
			free(sw->base);
			if (sw != &swstate)
				free(sw);
			expr.declare = 0;
		}
#line 2135 "exparse.c"
    break;

  case 22:
#line 363 "../../lib/expr/exparse.y"
                {
		loopop:
			if (!(yyvsp[-1].expr))
			{
				(yyvsp[-1].expr) = exnewnode(expr.program, CONSTANT, false, INTEGER, NULL, NULL);
				(yyvsp[-1].expr)->data.constant.value.integer = 1;
			}
			else if (!INTEGRAL((yyvsp[-1].expr)->type))
				(yyvsp[-1].expr) = excast(expr.program, (yyvsp[-1].expr), INTEGER, NULL, 0);
			(yyval.expr) = exnewnode(expr.program, (yyvsp[-2].id)->index, true, INTEGER, (yyvsp[-1].expr), NULL);
		}
#line 2151 "exparse.c"
    break;

  case 23:
#line 375 "../../lib/expr/exparse.y"
                {
			goto loopop;
		}
#line 2159 "exparse.c"
    break;

  case 24:
#line 379 "../../lib/expr/exparse.y"
                {
			if ((yyvsp[-1].expr))
			{
				if (expr.procedure && !expr.procedure->type)
					exerror("return in void function");
				(yyvsp[-1].expr) = excast(expr.program, (yyvsp[-1].expr), expr.procedure ? expr.procedure->type : INTEGER, NULL, 0);
			}
			(yyval.expr) = exnewnode(expr.program, RETURN, true, (yyvsp[-1].expr) ? (yyvsp[-1].expr)->type : 0, (yyvsp[-1].expr), NULL);
		}
#line 2173 "exparse.c"
    break;

  case 25:
#line 391 "../../lib/expr/exparse.y"
                {
			Switch_t*		sw;

			if (expr.swstate)
			{
				if (!(sw = calloc(1, sizeof(Switch_t))))
				{
					exnospace();
					sw = &swstate;
				}
				sw->prev = expr.swstate;
			}
			else
				sw = &swstate;
			expr.swstate = sw;
			sw->type = expr.declare;
			sw->firstcase = 0;
			sw->lastcase = 0;
			sw->defcase = 0;
			sw->def = 0;
			size_t n = 8;
			if (!(sw->base = calloc(n, sizeof(Extype_t*))))
			{
				exnospace();
				n = 0;
			}
			sw->cur = sw->base;
			sw->last = sw->base + n;
		}
#line 2207 "exparse.c"
    break;

  case 27:
#line 424 "../../lib/expr/exparse.y"
                {
			Switch_t*	sw = expr.swstate;

			(yyval.expr) = exnewnode(expr.program, CASE, true, 0, (yyvsp[0].expr), NULL);
			if (sw->cur > sw->base)
			{
				if (sw->lastcase)
					sw->lastcase->data.select.next = (yyval.expr);
				else
					sw->firstcase = (yyval.expr);
				sw->lastcase = (yyval.expr);
				size_t n = (size_t)(sw->cur - sw->base);
				sw->cur = sw->base;
				(yyval.expr)->data.select.constant = exalloc(expr.program, (n + 1) * sizeof(Extype_t*));
				memcpy((yyval.expr)->data.select.constant, sw->base, n * sizeof(Extype_t*));
				(yyval.expr)->data.select.constant[n] = 0;
			}
			else
				(yyval.expr)->data.select.constant = 0;
			if (sw->def)
			{
				sw->def = 0;
				if (sw->defcase)
					exerror("duplicate default in switch");
				else
					sw->defcase = (yyvsp[0].expr);
			}
		}
#line 2240 "exparse.c"
    break;

  case 30:
#line 459 "../../lib/expr/exparse.y"
                {
			if (expr.swstate->cur >= expr.swstate->last)
			{
				size_t n = (size_t)(expr.swstate->cur - expr.swstate->base);
				if (!(expr.swstate->base = realloc(expr.swstate->base, sizeof(Extype_t*) * 2 * n)))
				{
					exerror("too many case labels for switch");
					n = 0;
				}
				expr.swstate->cur = expr.swstate->base + n;
				expr.swstate->last = expr.swstate->base + 2 * n;
			}
			if (expr.swstate->cur)
			{
				(yyvsp[-1].expr) = excast(expr.program, (yyvsp[-1].expr), expr.swstate->type, NULL, 0);
				*expr.swstate->cur++ = &((yyvsp[-1].expr)->data.constant.value);
			}
		}
#line 2263 "exparse.c"
    break;

  case 31:
#line 478 "../../lib/expr/exparse.y"
                {
			expr.swstate->def = 1;
		}
#line 2271 "exparse.c"
    break;

  case 33:
#line 485 "../../lib/expr/exparse.y"
                {
			if ((yyvsp[0].expr))
				(yyval.expr) = (yyvsp[-2].expr) ? exnewnode(expr.program, ',', true, (yyvsp[0].expr)->type, (yyvsp[-2].expr), (yyvsp[0].expr)) : (yyvsp[0].expr);
		}
#line 2280 "exparse.c"
    break;

  case 34:
#line 491 "../../lib/expr/exparse.y"
                                 {checkName ((yyvsp[0].id)); expr.id=(yyvsp[0].id);}
#line 2286 "exparse.c"
    break;

  case 35:
#line 492 "../../lib/expr/exparse.y"
                {
			(yyval.expr) = 0;
			if (!(yyvsp[-3].id)->type || expr.declare)
				(yyvsp[-3].id)->type = expr.declare;
			if ((yyvsp[0].expr) && (yyvsp[0].expr)->op == PROCEDURE)
			{
				(yyvsp[-3].id)->lex = PROCEDURE;
				(yyvsp[-3].id)->type = (yyvsp[0].expr)->type;
				(yyvsp[-3].id)->value = (yyvsp[0].expr);
			}
			else
			{
				if ((yyvsp[-3].id)->type == 0) {
					exerror("%s: a variable cannot be void typed", (yyvsp[-3].id)->name);
				}
				(yyvsp[-3].id)->lex = DYNAMIC;
				(yyvsp[-3].id)->value = exnewnode(expr.program, 0, false, 0, NULL, NULL);
				if ((yyvsp[-1].integer) && (yyvsp[-3].id)->local == NULL)
				{
					static Dtdisc_t disc_key = {
						.key = offsetof(Exassoc_t, key),
						.size = sizeof(Extype_t),
						.comparf = cmpKey,
					};
					static Dtdisc_t disc_name = {.key = offsetof(Exassoc_t, name)};
					Dtdisc_t *const disc = (yyvsp[-1].integer) == INTEGER ? &disc_key : &disc_name;
					if (!((yyvsp[-3].id)->local = dtopen(disc, Dtoset)))
						exerror("%s: cannot initialize associative array", (yyvsp[-3].id)->name);
					(yyvsp[-3].id)->index_type = (yyvsp[-1].integer); /* -1 indicates no typechecking */
				}
				if ((yyvsp[0].expr))
				{
					if ((yyvsp[0].expr)->type != (yyvsp[-3].id)->type)
					{
						(yyvsp[0].expr)->type = (yyvsp[-3].id)->type;
						(yyvsp[0].expr)->data.operand.right = excast(expr.program, (yyvsp[0].expr)->data.operand.right, (yyvsp[-3].id)->type, NULL, 0);
					}
					(yyvsp[0].expr)->data.operand.left = exnewnode(expr.program, DYNAMIC, false, (yyvsp[-3].id)->type, NULL, NULL);
					(yyvsp[0].expr)->data.operand.left->data.variable.symbol = (yyvsp[-3].id);
					(yyval.expr) = (yyvsp[0].expr);
				}
				else if (!(yyvsp[-1].integer))
					(yyvsp[-3].id)->value->data.value = exzero((yyvsp[-3].id)->type);
			}
		}
#line 2336 "exparse.c"
    break;

  case 42:
#line 550 "../../lib/expr/exparse.y"
                {
			(yyval.expr) = 0;
		}
#line 2344 "exparse.c"
    break;

  case 43:
#line 554 "../../lib/expr/exparse.y"
                {
			(yyval.expr) = (yyvsp[0].expr);
		}
#line 2352 "exparse.c"
    break;

  case 44:
#line 560 "../../lib/expr/exparse.y"
                {
			(yyval.expr) = 0;
		}
#line 2360 "exparse.c"
    break;

  case 46:
#line 567 "../../lib/expr/exparse.y"
                {
			(yyval.expr) = (yyvsp[-1].expr);
		}
#line 2368 "exparse.c"
    break;

  case 47:
#line 571 "../../lib/expr/exparse.y"
                {
			(yyval.expr) = ((yyvsp[0].expr)->type == (yyvsp[-2].id)->type) ? (yyvsp[0].expr) : excast(expr.program, (yyvsp[0].expr), (yyvsp[-2].id)->type, NULL, 0);
		}
#line 2376 "exparse.c"
    break;

  case 48:
#line 575 "../../lib/expr/exparse.y"
                {
			long rel;

		relational:
			rel = INTEGER;
			goto coerce;
		binary:
			rel = 0;
		coerce:
			if (!(yyvsp[-2].expr)->type)
			{
				if (!(yyvsp[0].expr)->type)
					(yyvsp[-2].expr)->type = (yyvsp[0].expr)->type = rel ? STRING : INTEGER;
				else
					(yyvsp[-2].expr)->type = (yyvsp[0].expr)->type;
			}
			else if (!(yyvsp[0].expr)->type)
				(yyvsp[0].expr)->type = (yyvsp[-2].expr)->type;
			if ((yyvsp[-2].expr)->type != (yyvsp[0].expr)->type)
			{
				if ((yyvsp[-2].expr)->type == STRING)
					(yyvsp[-2].expr) = excast(expr.program, (yyvsp[-2].expr), (yyvsp[0].expr)->type, (yyvsp[0].expr), 0);
				else if ((yyvsp[0].expr)->type == STRING)
					(yyvsp[0].expr) = excast(expr.program, (yyvsp[0].expr), (yyvsp[-2].expr)->type, (yyvsp[-2].expr), 0);
				else if ((yyvsp[-2].expr)->type == FLOATING)
					(yyvsp[0].expr) = excast(expr.program, (yyvsp[0].expr), FLOATING, (yyvsp[-2].expr), 0);
				else if ((yyvsp[0].expr)->type == FLOATING)
					(yyvsp[-2].expr) = excast(expr.program, (yyvsp[-2].expr), FLOATING, (yyvsp[0].expr), 0);
			}
			if (!rel)
				rel = ((yyvsp[-2].expr)->type == STRING) ? STRING : (((yyvsp[-2].expr)->type == UNSIGNED) ? UNSIGNED : (yyvsp[0].expr)->type);
			(yyval.expr) = exnewnode(expr.program, (yyvsp[-1].op), true, rel, (yyvsp[-2].expr), (yyvsp[0].expr));
			if (!expr.program->errors && (yyvsp[-2].expr)->op == CONSTANT && (yyvsp[0].expr)->op == CONSTANT)
			{
				(yyval.expr)->data.constant.value = exeval(expr.program, (yyval.expr), NULL);
				/* If a constant string, re-allocate from program heap. This is because the
				 * value was constructed from string operators, which create a value in the 
				 * temporary heap, which is cleared when exeval is called again. 
				 */
				if ((yyval.expr)->type == STRING) {
					(yyval.expr)->data.constant.value.string =
						vmstrdup(expr.program->vm, (yyval.expr)->data.constant.value.string);
				}
				(yyval.expr)->binary = false;
				(yyval.expr)->op = CONSTANT;
				exfreenode(expr.program, (yyvsp[-2].expr));
				exfreenode(expr.program, (yyvsp[0].expr));
			}
			else if (!BUILTIN((yyvsp[-2].expr)->type) || !BUILTIN((yyvsp[0].expr)->type)) {
				checkBinary(expr.program, (yyvsp[-2].expr), (yyval.expr), (yyvsp[0].expr));
			}
		}
#line 2433 "exparse.c"
    break;

  case 49:
#line 628 "../../lib/expr/exparse.y"
                {
			goto binary;
		}
#line 2441 "exparse.c"
    break;

  case 50:
#line 632 "../../lib/expr/exparse.y"
                {
			goto binary;
		}
#line 2449 "exparse.c"
    break;

  case 51:
#line 636 "../../lib/expr/exparse.y"
                {
			goto binary;
		}
#line 2457 "exparse.c"
    break;

  case 52:
#line 640 "../../lib/expr/exparse.y"
                {
			goto binary;
		}
#line 2465 "exparse.c"
    break;

  case 53:
#line 644 "../../lib/expr/exparse.y"
                {
			goto binary;
		}
#line 2473 "exparse.c"
    break;

  case 54:
#line 648 "../../lib/expr/exparse.y"
                {
			goto binary;
		}
#line 2481 "exparse.c"
    break;

  case 55:
#line 652 "../../lib/expr/exparse.y"
                {
			goto relational;
		}
#line 2489 "exparse.c"
    break;

  case 56:
#line 656 "../../lib/expr/exparse.y"
                {
			goto relational;
		}
#line 2497 "exparse.c"
    break;

  case 57:
#line 660 "../../lib/expr/exparse.y"
                {
			goto relational;
		}
#line 2505 "exparse.c"
    break;

  case 58:
#line 664 "../../lib/expr/exparse.y"
                {
			goto relational;
		}
#line 2513 "exparse.c"
    break;

  case 59:
#line 668 "../../lib/expr/exparse.y"
                {
			goto relational;
		}
#line 2521 "exparse.c"
    break;

  case 60:
#line 672 "../../lib/expr/exparse.y"
                {
			goto binary;
		}
#line 2529 "exparse.c"
    break;

  case 61:
#line 676 "../../lib/expr/exparse.y"
                {
			goto binary;
		}
#line 2537 "exparse.c"
    break;

  case 62:
#line 680 "../../lib/expr/exparse.y"
                {
			goto binary;
		}
#line 2545 "exparse.c"
    break;

  case 63:
#line 684 "../../lib/expr/exparse.y"
                {
			goto binary;
		}
#line 2553 "exparse.c"
    break;

  case 64:
#line 688 "../../lib/expr/exparse.y"
                {
		logical:
			if ((yyvsp[-2].expr)->type == STRING)
				(yyvsp[-2].expr) = exnewnode(expr.program, S2B, true, INTEGER, (yyvsp[-2].expr), NULL);
			else if (!BUILTIN((yyvsp[-2].expr)->type))
				(yyvsp[-2].expr) = excast(expr.program, (yyvsp[-2].expr), INTEGER, NULL, 0);
			if ((yyvsp[0].expr)->type == STRING)
				(yyvsp[0].expr) = exnewnode(expr.program, S2B, true, INTEGER, (yyvsp[0].expr), NULL);
			else if (!BUILTIN((yyvsp[0].expr)->type))
				(yyvsp[0].expr) = excast(expr.program, (yyvsp[0].expr), INTEGER, NULL, 0);
			goto binary;
		}
#line 2570 "exparse.c"
    break;

  case 65:
#line 701 "../../lib/expr/exparse.y"
                {
			goto logical;
		}
#line 2578 "exparse.c"
    break;

  case 66:
#line 705 "../../lib/expr/exparse.y"
                {
			if ((yyvsp[-2].expr)->op == CONSTANT)
			{
				exfreenode(expr.program, (yyvsp[-2].expr));
				(yyval.expr) = (yyvsp[0].expr);
			}
			else
				(yyval.expr) = exnewnode(expr.program, ',', true, (yyvsp[0].expr)->type, (yyvsp[-2].expr), (yyvsp[0].expr));
		}
#line 2592 "exparse.c"
    break;

  case 67:
#line 714 "../../lib/expr/exparse.y"
                                 {expr.nolabel=1;}
#line 2598 "exparse.c"
    break;

  case 68:
#line 714 "../../lib/expr/exparse.y"
                                                            {expr.nolabel=0;}
#line 2604 "exparse.c"
    break;

  case 69:
#line 715 "../../lib/expr/exparse.y"
                {
			if (!(yyvsp[-3].expr)->type)
			{
				if (!(yyvsp[0].expr)->type)
					(yyvsp[-3].expr)->type = (yyvsp[0].expr)->type = INTEGER;
				else
					(yyvsp[-3].expr)->type = (yyvsp[0].expr)->type;
			}
			else if (!(yyvsp[0].expr)->type)
				(yyvsp[0].expr)->type = (yyvsp[-3].expr)->type;
			if ((yyvsp[-6].expr)->type == STRING)
				(yyvsp[-6].expr) = exnewnode(expr.program, S2B, true, INTEGER, (yyvsp[-6].expr), NULL);
			else if (!INTEGRAL((yyvsp[-6].expr)->type))
				(yyvsp[-6].expr) = excast(expr.program, (yyvsp[-6].expr), INTEGER, NULL, 0);
			if ((yyvsp[-3].expr)->type != (yyvsp[0].expr)->type)
			{
				if ((yyvsp[-3].expr)->type == STRING || (yyvsp[0].expr)->type == STRING)
					exerror("if statement string type mismatch");
				else if ((yyvsp[-3].expr)->type == FLOATING)
					(yyvsp[0].expr) = excast(expr.program, (yyvsp[0].expr), FLOATING, NULL, 0);
				else if ((yyvsp[0].expr)->type == FLOATING)
					(yyvsp[-3].expr) = excast(expr.program, (yyvsp[-3].expr), FLOATING, NULL, 0);
			}
			if ((yyvsp[-6].expr)->op == CONSTANT)
			{
				if ((yyvsp[-6].expr)->data.constant.value.integer)
				{
					(yyval.expr) = (yyvsp[-3].expr);
					exfreenode(expr.program, (yyvsp[0].expr));
				}
				else
				{
					(yyval.expr) = (yyvsp[0].expr);
					exfreenode(expr.program, (yyvsp[-3].expr));
				}
				exfreenode(expr.program, (yyvsp[-6].expr));
			}
			else
				(yyval.expr) = exnewnode(expr.program, '?', true, (yyvsp[-3].expr)->type, (yyvsp[-6].expr), exnewnode(expr.program, ':', true, (yyvsp[-3].expr)->type, (yyvsp[-3].expr), (yyvsp[0].expr)));
		}
#line 2649 "exparse.c"
    break;

  case 70:
#line 756 "../../lib/expr/exparse.y"
                {
		iunary:
			if ((yyvsp[0].expr)->type == STRING)
				(yyvsp[0].expr) = exnewnode(expr.program, S2B, true, INTEGER, (yyvsp[0].expr), NULL);
			else if (!INTEGRAL((yyvsp[0].expr)->type))
				(yyvsp[0].expr) = excast(expr.program, (yyvsp[0].expr), INTEGER, NULL, 0);
		unary:
			(yyval.expr) = exnewnode(expr.program, (yyvsp[-1].op), true, (yyvsp[0].expr)->type == UNSIGNED ? INTEGER : (yyvsp[0].expr)->type, (yyvsp[0].expr), NULL);
			if ((yyvsp[0].expr)->op == CONSTANT)
			{
				(yyval.expr)->data.constant.value = exeval(expr.program, (yyval.expr), NULL);
				(yyval.expr)->binary = false;
				(yyval.expr)->op = CONSTANT;
				exfreenode(expr.program, (yyvsp[0].expr));
			}
			else if (!BUILTIN((yyvsp[0].expr)->type)) {
				checkBinary(expr.program, (yyvsp[0].expr), (yyval.expr), 0);
			}
		}
#line 2673 "exparse.c"
    break;

  case 71:
#line 776 "../../lib/expr/exparse.y"
                {
			if ((yyvsp[0].id)->local == NULL)
              			exerror("cannot apply '#' operator to non-array %s", (yyvsp[0].id)->name);
			(yyval.expr) = exnewnode(expr.program, '#', false, INTEGER, NULL, NULL);
			(yyval.expr)->data.variable.symbol = (yyvsp[0].id);
		}
#line 2684 "exparse.c"
    break;

  case 72:
#line 783 "../../lib/expr/exparse.y"
                {
			goto iunary;
		}
#line 2692 "exparse.c"
    break;

  case 73:
#line 787 "../../lib/expr/exparse.y"
                {
			goto unary;
		}
#line 2700 "exparse.c"
    break;

  case 74:
#line 791 "../../lib/expr/exparse.y"
                {
			(yyval.expr) = (yyvsp[0].expr);
		}
#line 2708 "exparse.c"
    break;

  case 75:
#line 795 "../../lib/expr/exparse.y"
                {
			(yyval.expr) = exnewnode(expr.program, ADDRESS, false, T((yyvsp[0].expr)->type), (yyvsp[0].expr), NULL);
		}
#line 2716 "exparse.c"
    break;

  case 76:
#line 799 "../../lib/expr/exparse.y"
                {
			(yyval.expr) = exnewnode(expr.program, ARRAY, true, T((yyvsp[-3].id)->type), call(0, (yyvsp[-3].id), (yyvsp[-1].expr)), (yyvsp[-1].expr));
		}
#line 2724 "exparse.c"
    break;

  case 77:
#line 803 "../../lib/expr/exparse.y"
                {
			(yyval.expr) = exnewnode(expr.program, FUNCTION, true, T((yyvsp[-3].id)->type), call(0, (yyvsp[-3].id), (yyvsp[-1].expr)), (yyvsp[-1].expr));
		}
#line 2732 "exparse.c"
    break;

  case 78:
#line 807 "../../lib/expr/exparse.y"
                {
			(yyval.expr) = exnewsub (expr.program, (yyvsp[-1].expr), GSUB);
		}
#line 2740 "exparse.c"
    break;

  case 79:
#line 811 "../../lib/expr/exparse.y"
                {
			(yyval.expr) = exnewsub (expr.program, (yyvsp[-1].expr), SUB);
		}
#line 2748 "exparse.c"
    break;

  case 80:
#line 815 "../../lib/expr/exparse.y"
                {
			(yyval.expr) = exnewsubstr (expr.program, (yyvsp[-1].expr));
		}
#line 2756 "exparse.c"
    break;

  case 81:
#line 819 "../../lib/expr/exparse.y"
                {
			(yyval.expr) = exnewsplit (expr.program, (yyvsp[-5].id)->index, (yyvsp[-1].id), (yyvsp[-3].expr), NULL);
		}
#line 2764 "exparse.c"
    break;

  case 82:
#line 823 "../../lib/expr/exparse.y"
                {
			(yyval.expr) = exnewsplit (expr.program, (yyvsp[-7].id)->index, (yyvsp[-3].id), (yyvsp[-5].expr), (yyvsp[-1].expr));
		}
#line 2772 "exparse.c"
    break;

  case 83:
#line 827 "../../lib/expr/exparse.y"
                {
			if (!INTEGRAL((yyvsp[-1].expr)->type))
				(yyvsp[-1].expr) = excast(expr.program, (yyvsp[-1].expr), INTEGER, NULL, 0);
			(yyval.expr) = exnewnode(expr.program, EXIT, true, INTEGER, (yyvsp[-1].expr), NULL);
		}
#line 2782 "exparse.c"
    break;

  case 84:
#line 833 "../../lib/expr/exparse.y"
                {
			(yyval.expr) = exnewnode(expr.program, RAND, false, FLOATING, NULL, NULL);
		}
#line 2790 "exparse.c"
    break;

  case 85:
#line 837 "../../lib/expr/exparse.y"
                {
			(yyval.expr) = exnewnode(expr.program, SRAND, false, INTEGER, NULL, NULL);
		}
#line 2798 "exparse.c"
    break;

  case 86:
#line 841 "../../lib/expr/exparse.y"
                {
			if (!INTEGRAL((yyvsp[-1].expr)->type))
				(yyvsp[-1].expr) = excast(expr.program, (yyvsp[-1].expr), INTEGER, NULL, 0);
			(yyval.expr) = exnewnode(expr.program, SRAND, true, INTEGER, (yyvsp[-1].expr), NULL);
		}
#line 2808 "exparse.c"
    break;

  case 87:
#line 847 "../../lib/expr/exparse.y"
                {
			(yyval.expr) = exnewnode(expr.program, CALL, true, (yyvsp[-3].id)->type, NULL, (yyvsp[-1].expr));
			(yyval.expr)->data.call.procedure = (yyvsp[-3].id);
		}
#line 2817 "exparse.c"
    break;

  case 88:
#line 852 "../../lib/expr/exparse.y"
                {
			(yyval.expr) = exprint(expr.program, (yyvsp[-3].id), (yyvsp[-1].expr));
		}
#line 2825 "exparse.c"
    break;

  case 89:
#line 856 "../../lib/expr/exparse.y"
                {
			(yyval.expr) = exnewnode(expr.program, (yyvsp[-3].id)->index, false, (yyvsp[-3].id)->type, NULL, NULL);
			if ((yyvsp[-1].expr) && (yyvsp[-1].expr)->data.operand.left->type == INTEGER)
			{
				(yyval.expr)->data.print.descriptor = (yyvsp[-1].expr)->data.operand.left;
				(yyvsp[-1].expr) = (yyvsp[-1].expr)->data.operand.right;
			}
			else 
				switch ((yyvsp[-3].id)->index)
				{
				case QUERY:
					(yyval.expr)->data.print.descriptor = exnewnode(expr.program, CONSTANT, false, INTEGER, NULL, NULL);
					(yyval.expr)->data.print.descriptor->data.constant.value.integer = 2;
					break;
				case PRINTF:
					(yyval.expr)->data.print.descriptor = exnewnode(expr.program, CONSTANT, false, INTEGER, NULL, NULL);
					(yyval.expr)->data.print.descriptor->data.constant.value.integer = 1;
					break;
				case SPRINTF:
					(yyval.expr)->data.print.descriptor = 0;
					break;
				}
			(yyval.expr)->data.print.args = preprint((yyvsp[-1].expr));
		}
#line 2854 "exparse.c"
    break;

  case 90:
#line 881 "../../lib/expr/exparse.y"
                {
			Exnode_t*	x;

			(yyval.expr) = exnewnode(expr.program, (yyvsp[-3].id)->index, false, (yyvsp[-3].id)->type, NULL, NULL);
			if ((yyvsp[-1].expr) && (yyvsp[-1].expr)->data.operand.left->type == INTEGER)
			{
				(yyval.expr)->data.scan.descriptor = (yyvsp[-1].expr)->data.operand.left;
				(yyvsp[-1].expr) = (yyvsp[-1].expr)->data.operand.right;
			}
			else 
				switch ((yyvsp[-3].id)->index)
				{
				case SCANF:
					(yyval.expr)->data.scan.descriptor = 0;
					break;
				case SSCANF:
					if ((yyvsp[-1].expr) && (yyvsp[-1].expr)->data.operand.left->type == STRING)
					{
						(yyval.expr)->data.scan.descriptor = (yyvsp[-1].expr)->data.operand.left;
						(yyvsp[-1].expr) = (yyvsp[-1].expr)->data.operand.right;
					}
					else
						exerror("%s: string argument expected", (yyvsp[-3].id)->name);
					break;
				}
			if (!(yyvsp[-1].expr) || !(yyvsp[-1].expr)->data.operand.left || (yyvsp[-1].expr)->data.operand.left->type != STRING)
				exerror("%s: format argument expected", (yyvsp[-3].id)->name);
			(yyval.expr)->data.scan.format = (yyvsp[-1].expr)->data.operand.left;
			for (x = (yyval.expr)->data.scan.args = (yyvsp[-1].expr)->data.operand.right; x; x = x->data.operand.right)
			{
				if (x->data.operand.left->op != ADDRESS)
					exerror("%s: address argument expected", (yyvsp[-3].id)->name);
				x->data.operand.left = x->data.operand.left->data.operand.left;
			}
		}
#line 2894 "exparse.c"
    break;

  case 91:
#line 917 "../../lib/expr/exparse.y"
                {
			if ((yyvsp[0].expr))
			{
				if ((yyvsp[-1].expr)->op == ID && !expr.program->disc->setf)
					exerror("%s: variable assignment not supported", (yyvsp[-1].expr)->data.variable.symbol->name);
				else
				{
					if (!(yyvsp[-1].expr)->type)
						(yyvsp[-1].expr)->type = (yyvsp[0].expr)->type;
					else if ((yyvsp[0].expr)->type != (yyvsp[-1].expr)->type)
					{
						(yyvsp[0].expr)->type = (yyvsp[-1].expr)->type;
						(yyvsp[0].expr)->data.operand.right = excast(expr.program, (yyvsp[0].expr)->data.operand.right, (yyvsp[-1].expr)->type, NULL, 0);
					}
					(yyvsp[0].expr)->data.operand.left = (yyvsp[-1].expr);
					(yyval.expr) = (yyvsp[0].expr);
				}
			}
		}
#line 2918 "exparse.c"
    break;

  case 92:
#line 937 "../../lib/expr/exparse.y"
                {
		pre:
			if ((yyvsp[0].expr)->type == STRING)
				exerror("++ and -- invalid for string variables");
			(yyval.expr) = exnewnode(expr.program, (yyvsp[-1].op), false, (yyvsp[0].expr)->type, (yyvsp[0].expr), NULL);
			(yyval.expr)->subop = PRE;
		}
#line 2930 "exparse.c"
    break;

  case 93:
#line 945 "../../lib/expr/exparse.y"
                {
		pos:
			if ((yyvsp[-1].expr)->type == STRING)
				exerror("++ and -- invalid for string variables");
			(yyval.expr) = exnewnode(expr.program, (yyvsp[0].op), false, (yyvsp[-1].expr)->type, (yyvsp[-1].expr), NULL);
			(yyval.expr)->subop = POS;
		}
#line 2942 "exparse.c"
    break;

  case 94:
#line 953 "../../lib/expr/exparse.y"
                {
			if ((yyvsp[0].id)->local == NULL)
              			exerror("cannot apply IN to non-array %s", (yyvsp[0].id)->name);
			if (((yyvsp[0].id)->index_type > 0) && ((yyvsp[-2].expr)->type != (yyvsp[0].id)->index_type))
            		    exerror("%s indices must have type %s, not %s", 
				(yyvsp[0].id)->name, extypename(expr.program, (yyvsp[0].id)->index_type),extypename(expr.program, (yyvsp[-2].expr)->type));
			(yyval.expr) = exnewnode(expr.program, IN_OP, false, INTEGER, NULL, NULL);
			(yyval.expr)->data.variable.symbol = (yyvsp[0].id);
			(yyval.expr)->data.variable.index = (yyvsp[-2].expr);
		}
#line 2957 "exparse.c"
    break;

  case 95:
#line 964 "../../lib/expr/exparse.y"
                {
			goto pre;
		}
#line 2965 "exparse.c"
    break;

  case 96:
#line 968 "../../lib/expr/exparse.y"
                {
			goto pos;
		}
#line 2973 "exparse.c"
    break;

  case 100:
#line 978 "../../lib/expr/exparse.y"
                {
			(yyval.expr) = exnewnode(expr.program, CONSTANT, false, (yyvsp[0].id)->type, NULL, NULL);
			if (!expr.program->disc->reff)
				exerror("%s: identifier references not supported", (yyvsp[0].id)->name);
			else
				(yyval.expr)->data.constant.value = expr.program->disc->reff(expr.program, (yyval.expr), (yyvsp[0].id), NULL);
		}
#line 2985 "exparse.c"
    break;

  case 101:
#line 986 "../../lib/expr/exparse.y"
                {
			(yyval.expr) = exnewnode(expr.program, CONSTANT, false, FLOATING, NULL, NULL);
			(yyval.expr)->data.constant.value.floating = (yyvsp[0].floating);
		}
#line 2994 "exparse.c"
    break;

  case 102:
#line 991 "../../lib/expr/exparse.y"
                {
			(yyval.expr) = exnewnode(expr.program, CONSTANT, false, INTEGER, NULL, NULL);
			(yyval.expr)->data.constant.value.integer = (yyvsp[0].integer);
		}
#line 3003 "exparse.c"
    break;

  case 103:
#line 996 "../../lib/expr/exparse.y"
                {
			(yyval.expr) = exnewnode(expr.program, CONSTANT, false, STRING, NULL, NULL);
			(yyval.expr)->data.constant.value.string = (yyvsp[0].string);
		}
#line 3012 "exparse.c"
    break;

  case 104:
#line 1001 "../../lib/expr/exparse.y"
                {
			(yyval.expr) = exnewnode(expr.program, CONSTANT, false, UNSIGNED, NULL, NULL);
			(yyval.expr)->data.constant.value.integer = (yyvsp[0].integer);
		}
#line 3021 "exparse.c"
    break;

  case 110:
#line 1017 "../../lib/expr/exparse.y"
                {
			(yyval.expr) = makeVar(expr.program, (yyvsp[-1].id), 0, 0, (yyvsp[0].reference));
		}
#line 3029 "exparse.c"
    break;

  case 111:
#line 1021 "../../lib/expr/exparse.y"
                {
			Exnode_t *n = exnewnode(expr.program, DYNAMIC, false, (yyvsp[-2].id)->type, NULL, NULL);
			n->data.variable.symbol = (yyvsp[-2].id);
			n->data.variable.reference = 0;
			if (((n->data.variable.index = (yyvsp[-1].expr)) == 0) != ((yyvsp[-2].id)->local == NULL))
				exerror("%s: is%s an array", (yyvsp[-2].id)->name, (yyvsp[-2].id)->local != NULL ? "" : " not");
			if ((yyvsp[-2].id)->local != NULL && ((yyvsp[-2].id)->index_type > 0)) {
				if ((yyvsp[-1].expr)->type != (yyvsp[-2].id)->index_type)
					exerror("%s: indices must have type %s, not %s", 
						(yyvsp[-2].id)->name, extypename(expr.program, (yyvsp[-2].id)->index_type),extypename(expr.program, (yyvsp[-1].expr)->type));
			}
			if ((yyvsp[0].reference)) {
				n->data.variable.dyna = exnewnode(expr.program, 0, false, 0, NULL, NULL);
				(yyval.expr) = makeVar(expr.program, (yyvsp[-2].id), (yyvsp[-1].expr), n, (yyvsp[0].reference));
			}
			else (yyval.expr) = n;
		}
#line 3051 "exparse.c"
    break;

  case 112:
#line 1039 "../../lib/expr/exparse.y"
                {
			(yyval.expr) = exnewnode(expr.program, ID, false, STRING, NULL, NULL);
			(yyval.expr)->data.variable.symbol = (yyvsp[0].id);
			(yyval.expr)->data.variable.reference = 0;
			(yyval.expr)->data.variable.index = 0;
			(yyval.expr)->data.variable.dyna = 0;
			if (!(expr.program->disc->flags & EX_UNDECLARED))
				exerror("unknown identifier");
		}
#line 3065 "exparse.c"
    break;

  case 113:
#line 1051 "../../lib/expr/exparse.y"
                {
			(yyval.integer) = 0;
		}
#line 3073 "exparse.c"
    break;

  case 114:
#line 1055 "../../lib/expr/exparse.y"
                {
			(yyval.integer) = -1;
		}
#line 3081 "exparse.c"
    break;

  case 115:
#line 1059 "../../lib/expr/exparse.y"
                {
			/* If DECLARE is VOID, its type is 0, so this acts like
			 * the empty case.
			 */
			if (INTEGRAL((yyvsp[-1].id)->type))
				(yyval.integer) = INTEGER;
			else
				(yyval.integer) = (yyvsp[-1].id)->type;
				
		}
#line 3096 "exparse.c"
    break;

  case 116:
#line 1072 "../../lib/expr/exparse.y"
                {
			(yyval.expr) = 0;
		}
#line 3104 "exparse.c"
    break;

  case 117:
#line 1076 "../../lib/expr/exparse.y"
                {
			(yyval.expr) = (yyvsp[-1].expr);
		}
#line 3112 "exparse.c"
    break;

  case 118:
#line 1082 "../../lib/expr/exparse.y"
                {
			(yyval.expr) = 0;
		}
#line 3120 "exparse.c"
    break;

  case 119:
#line 1086 "../../lib/expr/exparse.y"
                {
			(yyval.expr) = (yyvsp[0].expr)->data.operand.left;
			(yyvsp[0].expr)->data.operand.left = (yyvsp[0].expr)->data.operand.right = 0;
			exfreenode(expr.program, (yyvsp[0].expr));
		}
#line 3130 "exparse.c"
    break;

  case 120:
#line 1094 "../../lib/expr/exparse.y"
                {
			(yyval.expr) = exnewnode(expr.program, ',', true, 0, exnewnode(expr.program, ',', true, (yyvsp[0].expr)->type, (yyvsp[0].expr), NULL), NULL);
			(yyval.expr)->data.operand.right = (yyval.expr)->data.operand.left;
		}
#line 3139 "exparse.c"
    break;

  case 121:
#line 1099 "../../lib/expr/exparse.y"
                {
			(yyvsp[-2].expr)->data.operand.right = (yyvsp[-2].expr)->data.operand.right->data.operand.right = exnewnode(expr.program, ',', true, (yyvsp[-2].expr)->type, (yyvsp[0].expr), NULL);
		}
#line 3147 "exparse.c"
    break;

  case 122:
#line 1105 "../../lib/expr/exparse.y"
                {
			(yyval.expr) = 0;
		}
#line 3155 "exparse.c"
    break;

  case 123:
#line 1109 "../../lib/expr/exparse.y"
                {
			(yyval.expr) = 0;
			if ((yyvsp[0].id)->type)
				exerror("(void) expected");
		}
#line 3165 "exparse.c"
    break;

  case 125:
#line 1118 "../../lib/expr/exparse.y"
                {
			(yyval.expr) = exnewnode(expr.program, ',', true, (yyvsp[0].expr)->type, (yyvsp[0].expr), NULL);
		}
#line 3173 "exparse.c"
    break;

  case 126:
#line 1122 "../../lib/expr/exparse.y"
                {
			Exnode_t*	x;
			Exnode_t*	y;

			(yyval.expr) = (yyvsp[-2].expr);
			for (x = (yyvsp[-2].expr); (y = x->data.operand.right); x = y);
			x->data.operand.right = exnewnode(expr.program, ',', true, (yyvsp[0].expr)->type, (yyvsp[0].expr), NULL);
		}
#line 3186 "exparse.c"
    break;

  case 127:
#line 1132 "../../lib/expr/exparse.y"
                                {expr.declare=(yyvsp[0].id)->type;}
#line 3192 "exparse.c"
    break;

  case 128:
#line 1133 "../../lib/expr/exparse.y"
                {
			if ((yyvsp[-2].id)->type == 0) {
				exerror("%s: parameters to functions cannot be void typed", (yyvsp[0].id)->name);
			}
			(yyval.expr) = exnewnode(expr.program, ID, false, (yyvsp[-2].id)->type, NULL, NULL);
			(yyval.expr)->data.variable.symbol = (yyvsp[0].id);
			(yyvsp[0].id)->lex = DYNAMIC;
			(yyvsp[0].id)->type = (yyvsp[-2].id)->type;
			(yyvsp[0].id)->value = exnewnode(expr.program, 0, false, 0, NULL, NULL);
			expr.procedure->data.procedure.arity++;
			expr.declare = 0;
		}
#line 3209 "exparse.c"
    break;

  case 129:
#line 1148 "../../lib/expr/exparse.y"
                {
			(yyval.reference) = expr.refs = 0;
		}
#line 3217 "exparse.c"
    break;

  case 130:
#line 1152 "../../lib/expr/exparse.y"
                {
			Exref_t*	r;

			r = ALLOCATE(expr.program, Exref_t);
			*r = (Exref_t){0};
			r->symbol = (yyvsp[0].id);
			expr.refs = r;
			r->next = 0;
			r->index = 0;
			(yyval.reference) = expr.refs;
		}
#line 3233 "exparse.c"
    break;

  case 131:
#line 1164 "../../lib/expr/exparse.y"
                {
			Exref_t*	r;
			Exref_t*	l;

			r = ALLOCATE(expr.program, Exref_t);
			*r = (Exref_t){0};
			r->symbol = (yyvsp[0].id);
			r->index = 0;
			r->next = 0;
			l = ALLOCATE(expr.program, Exref_t);
			*l = (Exref_t){0};
			l->symbol = (yyvsp[-1].id);
			l->index = 0;
			l->next = r;
			expr.refs = l;
			(yyval.reference) = expr.refs;
		}
#line 3255 "exparse.c"
    break;

  case 132:
#line 1184 "../../lib/expr/exparse.y"
                {
			(yyval.id) = (yyvsp[0].id);
		}
#line 3263 "exparse.c"
    break;

  case 133:
#line 1188 "../../lib/expr/exparse.y"
                {
			(yyval.id) = (yyvsp[0].id);
		}
#line 3271 "exparse.c"
    break;

  case 134:
#line 1193 "../../lib/expr/exparse.y"
                {
			(yyval.expr) = 0;
		}
#line 3279 "exparse.c"
    break;

  case 135:
#line 1197 "../../lib/expr/exparse.y"
                {
			(yyval.expr) = exnewnode(expr.program, '=', true, (yyvsp[0].expr)->type, NULL, (yyvsp[0].expr));
			(yyval.expr)->subop = (yyvsp[-1].op);
		}
#line 3288 "exparse.c"
    break;

  case 137:
#line 1204 "../../lib/expr/exparse.y"
                            {
				if (expr.procedure)
					exerror("%s: nested function definitions not supported", expr.id->name);
				expr.procedure = exnewnode(expr.program, PROCEDURE, true, expr.declare, NULL, NULL);
				if (!streq(expr.id->name, "begin"))
				{
					static Dtdisc_t disc = {.key = offsetof(Exid_t, name)};
					if (!(expr.procedure->data.procedure.frame = dtopen(&disc, Dtset)) || !dtview(expr.procedure->data.procedure.frame, expr.program->symbols))
						exnospace();
					expr.program->symbols = expr.program->frame = expr.procedure->data.procedure.frame;
				}
				expr.declare = 0;
			}
#line 3306 "exparse.c"
    break;

  case 138:
#line 1216 "../../lib/expr/exparse.y"
                                  {
				expr.id->lex = PROCEDURE;
				expr.id->type = expr.procedure->type;
				expr.declare = 0;
			}
#line 3316 "exparse.c"
    break;

  case 139:
#line 1221 "../../lib/expr/exparse.y"
                {
			(yyval.expr) = expr.procedure;
			expr.procedure = 0;
			if (expr.program->frame)
			{
				expr.program->symbols = expr.program->frame->view;
				dtview(expr.program->frame, NULL);
				expr.program->frame = 0;
			}
			(yyval.expr)->data.operand.left = (yyvsp[-5].expr);
			(yyval.expr)->data.operand.right = excast(expr.program, (yyvsp[-1].expr), (yyval.expr)->type, NULL, 0);

			/*
			 * NOTE: procedure definition was slipped into the
			 *	 declaration initializer statement production,
			 *	 therefore requiring the statement terminator
			 */

			exunlex(expr.program, ';');
		}
#line 3341 "exparse.c"
    break;


#line 3345 "exparse.c"

      default: break;
    }
  /* User semantic actions sometimes alter yychar, and that requires
     that yytoken be updated with the new translation.  We take the
     approach of translating immediately before every use of yytoken.
     One alternative is translating here after every semantic action,
     but that translation would be missed if the semantic action invokes
     YYABORT, YYACCEPT, or YYERROR immediately after altering yychar or
     if it invokes YYBACKUP.  In the case of YYABORT or YYACCEPT, an
     incorrect destructor might then be invoked immediately.  In the
     case of YYERROR or YYBACKUP, subsequent parser actions might lead
     to an incorrect destructor call or verbose syntax error message
     before the lookahead is translated.  */
  YY_SYMBOL_PRINT ("-> $$ =", yyr1[yyn], &yyval, &yyloc);

  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);

  *++yyvsp = yyval;

  /* Now 'shift' the result of the reduction.  Determine what state
     that goes to, based on the state we popped back to and the rule
     number reduced by.  */
  {
    const int yylhs = yyr1[yyn] - YYNTOKENS;
    const int yyi = yypgoto[yylhs] + *yyssp;
    yystate = (0 <= yyi && yyi <= YYLAST && yycheck[yyi] == *yyssp
               ? yytable[yyi]
               : yydefgoto[yylhs]);
  }

  goto yynewstate;


/*--------------------------------------.
| yyerrlab -- here on detecting error.  |
`--------------------------------------*/
yyerrlab:
  /* Make sure we have latest lookahead translation.  See comments at
     user semantic actions for why this is necessary.  */
  yytoken = yychar == YYEMPTY ? YYEMPTY : YYTRANSLATE (yychar);

  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;
#if ! YYERROR_VERBOSE
      yyerror (YY_("syntax error"));
#else
# define YYSYNTAX_ERROR yysyntax_error (&yymsg_alloc, &yymsg, \
                                        yyssp, yytoken)
      {
        char const *yymsgp = YY_("syntax error");
        int yysyntax_error_status;
        yysyntax_error_status = YYSYNTAX_ERROR;
        if (yysyntax_error_status == 0)
          yymsgp = yymsg;
        else if (yysyntax_error_status == 1)
          {
            if (yymsg != yymsgbuf)
              YYSTACK_FREE (yymsg);
            yymsg = YY_CAST (char *, YYSTACK_ALLOC (YY_CAST (YYSIZE_T, yymsg_alloc)));
            if (!yymsg)
              {
                yymsg = yymsgbuf;
                yymsg_alloc = sizeof yymsgbuf;
                yysyntax_error_status = 2;
              }
            else
              {
                yysyntax_error_status = YYSYNTAX_ERROR;
                yymsgp = yymsg;
              }
          }
        yyerror (yymsgp);
        if (yysyntax_error_status == 2)
          goto yyexhaustedlab;
      }
# undef YYSYNTAX_ERROR
#endif
    }



  if (yyerrstatus == 3)
    {
      /* If just tried and failed to reuse lookahead token after an
         error, discard it.  */

      if (yychar <= YYEOF)
        {
          /* Return failure if at end of input.  */
          if (yychar == YYEOF)
            YYABORT;
        }
      else
        {
          yydestruct ("Error: discarding",
                      yytoken, &yylval);
          yychar = YYEMPTY;
        }
    }

  /* Else will try to reuse lookahead token after shifting the error
     token.  */
  goto yyerrlab1;


/*---------------------------------------------------.
| yyerrorlab -- error raised explicitly by YYERROR.  |
`---------------------------------------------------*/
yyerrorlab:
  /* Pacify compilers when the user code never invokes YYERROR and the
     label yyerrorlab therefore never appears in user code.  */
  if (0)
    YYERROR;

  /* Do not reclaim the symbols of the rule whose action triggered
     this YYERROR.  */
  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);
  yystate = *yyssp;
  goto yyerrlab1;


/*-------------------------------------------------------------.
| yyerrlab1 -- common code for both syntax error and YYERROR.  |
`-------------------------------------------------------------*/
yyerrlab1:
  yyerrstatus = 3;      /* Each real token shifted decrements this.  */

  for (;;)
    {
      yyn = yypact[yystate];
      if (!yypact_value_is_default (yyn))
        {
          yyn += YYTERROR;
          if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYTERROR)
            {
              yyn = yytable[yyn];
              if (0 < yyn)
                break;
            }
        }

      /* Pop the current state because it cannot handle the error token.  */
      if (yyssp == yyss)
        YYABORT;


      yydestruct ("Error: popping",
                  yystos[yystate], yyvsp);
      YYPOPSTACK (1);
      yystate = *yyssp;
      YY_STACK_PRINT (yyss, yyssp);
    }

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END


  /* Shift the error token.  */
  YY_SYMBOL_PRINT ("Shifting", yystos[yyn], yyvsp, yylsp);

  yystate = yyn;
  goto yynewstate;


/*-------------------------------------.
| yyacceptlab -- YYACCEPT comes here.  |
`-------------------------------------*/
yyacceptlab:
  yyresult = 0;
  goto yyreturn;


/*-----------------------------------.
| yyabortlab -- YYABORT comes here.  |
`-----------------------------------*/
yyabortlab:
  yyresult = 1;
  goto yyreturn;


#if !defined yyoverflow || YYERROR_VERBOSE
/*-------------------------------------------------.
| yyexhaustedlab -- memory exhaustion comes here.  |
`-------------------------------------------------*/
yyexhaustedlab:
  yyerror (YY_("memory exhausted"));
  yyresult = 2;
  /* Fall through.  */
#endif


/*-----------------------------------------------------.
| yyreturn -- parsing is finished, return the result.  |
`-----------------------------------------------------*/
yyreturn:
  if (yychar != YYEMPTY)
    {
      /* Make sure we have latest lookahead translation.  See comments at
         user semantic actions for why this is necessary.  */
      yytoken = YYTRANSLATE (yychar);
      yydestruct ("Cleanup: discarding lookahead",
                  yytoken, &yylval);
    }
  /* Do not reclaim the symbols of the rule whose action triggered
     this YYABORT or YYACCEPT.  */
  YYPOPSTACK (yylen);
  YY_STACK_PRINT (yyss, yyssp);
  while (yyssp != yyss)
    {
      yydestruct ("Cleanup: popping",
                  yystos[+*yyssp], yyvsp);
      YYPOPSTACK (1);
    }
#ifndef yyoverflow
  if (yyss != yyssa)
    YYSTACK_FREE (yyss);
#endif
#if YYERROR_VERBOSE
  if (yymsg != yymsgbuf)
    YYSTACK_FREE (yymsg);
#endif
  return yyresult;
}
#line 1243 "../../lib/expr/exparse.y"


const char *exop(size_t index) {

  /* yytname is generated by the %token-table directive */

  /* find the index of MINTOKEN */
  size_t minid;
  for (minid = 0; yytname[minid] != NULL; ++minid) {
    if (strcmp(yytname[minid], "MINTOKEN") == 0) {
      break;
    }
  }

  assert(yytname[minid] != NULL
    && "failed to find MINTOKEN; incorrect token list in exparse.y?");

  /* find the requested token */
  {
    size_t i, j;
    for (i = j = minid; yytname[i] != NULL; ++i) {

      /* if this token is not a word, skip it */
      {
        size_t k;
        for (k = 0; yytname[i][k] != '\0'; ++k) {
          if (yytname[i][k] != '_' && !gv_isalnum(yytname[i][k])) {
            break;
          }
        }
        if (yytname[i][k] != '\0') {
          continue;
        }
      }

      if (j == index + minid) {
        return yytname[i];
      }
      ++j;
    }
  }

  /* failed to find the requested token */
  return NULL;
}

void ex_error(const char *message) {
  exerror("%s", message);
}

#include <expr/exgram.h>
