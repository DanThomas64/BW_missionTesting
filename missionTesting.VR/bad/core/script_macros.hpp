#include "\z\ace\addons\main\script_macros.hpp"
#define ACE_PREFIX ace
#define ACEGVAR(module,var) TRIPLES(ACE_PREFIX,module,var)
#define QACEGVAR(module,var) QUOTE(ACEGVAR(module,var))
#define ACEFUNC(var1,var2) TRIPLES(DOUBLES(ACE_PREFIX,var1),fnc,var2)
#define DACEFUNC(var1,var2) TRIPLES(DOUBLES(ACE_PREFIX,var1),fnc,var2)
#define QACEFUNC(var1,var2) QUOTE(DACEFUNC(var1,var2))
#define ACECSTRING(var1,var2) QUOTE(TRIPLES($STR,DOUBLES(ACE_PREFIX,var1),var2))
#define ACELSTRING(var1,var2) QUOTE(TRIPLES(STR,DOUBLES(ACE_PREFIX,var1),var2))
#define CFUNC(var1) EFUNC(core,var1)
#ifdef CUSTOM_FOLDER
    #define PATHTO_SYS(var1,var2,var3) ##CUSTOM_FOLDER\##var3.sqf
    #define PATHTOF_SYS(var1,var2,var3) ##CUSTOM_FOLDER\##var3
    #define PATHTOF2_SYS(var1,var2,var3) ##CUSTOM_FOLDER\##var3
#else
    #define PATHTO_SYS(var1,var2,var3) ##var1\##var2\##var3.sqf
    #define PATHTOF_SYS(var1,var2,var3) ##var1\##var2\##var3
    #define PATHTOF2_SYS(var1,var2,var3) ##var1\##var2\##var3
#endif
/************************** REMOVAL OF MACROS ***********************/
#undef MAINPREFIX
#undef SUBPREFIX
#undef VERSION_AR
#undef VERSION_CONFIG
#undef VERSIONING_SYS
#undef VERSIONING
#undef PRELOAD_ADDONS
#undef BWC_CONFIG
#undef XEH_DISABLED
#undef XEH_PRE_INIT
#undef XEH_PRE_CINIT
#undef XEH_PRE_SINIT
#undef XEH_POST_INIT
#undef XEH_POST_CINIT
#undef XEH_POST_SINIT
#undef PATHTO_FNC

#define TEXT_ORANGE [1,0.5,0,1]
#define TEXT_RED [1,0,0,1]
#define TEXT_BLUE [0,0.5,1,1]
#define A_PASSFAIL ["FAIL","PASS"]
#define A_CHECK ["X","O"]
#define A_MISSION_TYPE ["COOP","TVT"]
#define A_MISSION_TAGS ["None","NIGHT","DAWN","MSV","TvT1","TvT2","AH"]
#define S_NEWTEXTLINE _textArray pushBack format

