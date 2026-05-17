import { useState, useEffect, useRef, useCallback } from "react";

const CONFIGS = {
  rite: {
    label: "Rite",
    category: "Habit Tracker",
    bg: ["#0F172A", "#0F172A"],
    logoColor: "#22C55E",
    glowColor: "rgba(34,197,94,0.25)",
    textColor: "#F8F9FA",
    taglineColor: "rgba(248,249,250,0.55)",
    wordmark: "RITE",
    tagline: "Build what lasts.",
    font: "'Clash Display', 'DM Sans', sans-serif",
    taglineFont: "'DM Sans', sans-serif",
    animStyle: "spring",
    duration: 1100,
    logoMark: "R",
    logoShape: "geometric",
    accent: "#22C55E",
    exitStyle: "zoom",
    userTier: "millennial-pro",
  },
  aria: {
    label: "ARIA",
    category: "AI Companion",
    bg: ["#1C1033", "#2D1B69"],
    logoColor: "#F59E0B",
    glowColor: "rgba(245,158,11,0.3)",
    textColor: "#FEF3C7",
    taglineColor: "rgba(254,243,199,0.5)",
    wordmark: "ARIA",
    tagline: "Always here.",
    font: "'Plus Jakarta Sans', sans-serif",
    taglineFont: "'Plus Jakarta Sans', sans-serif",
    animStyle: "bloom",
    duration: 1500,
    logoMark: "A",
    logoShape: "circle",
    accent: "#F59E0B",
    exitStyle: "dissolve",
    userTier: "wellness",
  },
  vault: {
    label: "VaultPDF",
    category: "Security Tools",
    bg: ["#09090B", "#0D0D10"],
    logoColor: "#3B82F6",
    glowColor: "rgba(59,130,246,0.2)",
    textColor: "#E2E8F0",
    taglineColor: "rgba(226,232,240,0)",
    wordmark: "VAULT",
    tagline: "",
    font: "'JetBrains Mono', 'Courier New', monospace",
    taglineFont: "'JetBrains Mono', monospace",
    animStyle: "instant",
    duration: 800,
    logoMark: "V",
    logoShape: "diamond",
    accent: "#3B82F6",
    exitStyle: "cut",
    userTier: "power-user",
  },
  custom: {
    label: "Custom App",
    category: "Creative",
    bg: ["#18181B", "#27272A"],
    logoColor: "#E879F9",
    glowColor: "rgba(232,121,249,0.25)",
    textColor: "#FAF5FF",
    taglineColor: "rgba(250,245,255,0.5)",
    wordmark: "BLOOM",
    tagline: "Create fearlessly.",
    font: "'Syne', sans-serif",
    taglineFont: "'Satoshi', sans-serif",
    animStyle: "kinetic",
    duration: 900,
    logoMark: "B",
    logoShape: "hexagon",
    accent: "#E879F9",
    exitStyle: "dissolve",
    userTier: "gen-z",
  }
};

const ANIM_LABELS = {
  spring: { name: "Spring", desc: "Logo blooms with physics overshoot" },
  bloom: { name: "Bloom", desc: "Soft glow emergence, slow & warm" },
  instant: { name: "Instant", desc: "Deliberate restraint, < 300ms" },
  kinetic: { name: "Kinetic", desc: "Bold entrance, scale + rotate" },
};

const EXIT_LABELS = {
  zoom: "Zoom to Content",
  dissolve: "Cross-Dissolve",
  cut: "Instant Cut",
};

function LogoMark({ shape, color, glow, letter, animPhase, animStyle }) {
  const scale = animPhase >= 1 ? 1 : animPhase >= 0 ? (0.8 + animPhase * 0.2) : 0.8;
  const opacity = animPhase >= 0.5 ? 1 : animPhase * 2;
  const extraScale = animStyle === "spring" && animPhase > 0.7 && animPhase < 0.85 ? 1.04 : 1;
  const rotate = animStyle === "kinetic" ? (1 - Math.min(animPhase, 1)) * -15 : 0;

  const baseStyle = {
    transform: `scale(${scale * extraScale}) rotate(${rotate}deg)`,
    opacity,
    transition: "none",
    willChange: "transform, opacity",
  };

  const glowStyle = {
    filter: `drop-shadow(0 0 ${20 + animPhase * 30}px ${glow}) drop-shadow(0 0 ${8 + animPhase * 12}px ${color}88)`,
  };

  if (shape === "circle") {
    return (
      <div style={{ ...baseStyle, ...glowStyle }}>
        <svg width="88" height="88" viewBox="0 0 88 88">
          <circle cx="44" cy="44" r="36" fill="none" stroke={color} strokeWidth="3" strokeOpacity="0.3" />
          <circle cx="44" cy="44" r="28" fill="none" stroke={color} strokeWidth="5" />
          <circle cx="44" cy="44" r="14" fill={color} fillOpacity="0.15" />
          <circle cx="44" cy="44" r="7" fill={color} />
          <text x="44" y="49" textAnchor="middle" fill={color} fontSize="16" fontFamily="'Plus Jakarta Sans', sans-serif" fontWeight="300">{letter}</text>
        </svg>
      </div>
    );
  }

  if (shape === "diamond") {
    return (
      <div style={{ ...baseStyle, ...glowStyle }}>
        <svg width="88" height="88" viewBox="0 0 88 88">
          <polygon points="44,6 80,44 44,82 8,44" fill="none" stroke={color} strokeWidth="2" strokeOpacity="0.3" />
          <polygon points="44,16 70,44 44,72 18,44" fill="none" stroke={color} strokeWidth="3.5" />
          <text x="44" y="50" textAnchor="middle" fill={color} fontSize="22" fontFamily="'JetBrains Mono', monospace" fontWeight="500">{letter}</text>
        </svg>
      </div>
    );
  }

  if (shape === "hexagon") {
    return (
      <div style={{ ...baseStyle, ...glowStyle }}>
        <svg width="88" height="88" viewBox="0 0 88 88">
          <polygon points="44,4 79,24 79,64 44,84 9,64 9,24" fill="none" stroke={color} strokeWidth="2" strokeOpacity="0.25" />
          <polygon points="44,14 70,29 70,59 44,74 18,59 18,29" fill="none" stroke={color} strokeWidth="3" />
          <text x="44" y="50" textAnchor="middle" fill={color} fontSize="24" fontFamily="'Syne', sans-serif" fontWeight="800">{letter}</text>
        </svg>
      </div>
    );
  }

  // geometric (default for Rite)
  return (
    <div style={{ ...baseStyle, ...glowStyle }}>
      <svg width="88" height="88" viewBox="0 0 88 88">
        <rect x="8" y="8" width="72" height="72" rx="18" fill="none" stroke={color} strokeWidth="2" strokeOpacity="0.2" />
        <rect x="14" y="14" width="60" height="60" rx="14" fill={color} fillOpacity="0.08" />
        <text x="44" y="54" textAnchor="middle" fill={color} fontSize="36" fontFamily="'Clash Display', 'DM Sans', sans-serif" fontWeight="600">{letter}</text>
      </svg>
    </div>
  );
}

function GridNoise({ color }) {
  return (
    <svg style={{ position: "absolute", inset: 0, width: "100%", height: "100%", opacity: 0.035, pointerEvents: "none" }}>
      <defs>
        <pattern id="grid" width="32" height="32" patternUnits="userSpaceOnUse">
          <path d="M 32 0 L 0 0 0 32" fill="none" stroke={color} strokeWidth="0.5" />
        </pattern>
      </defs>
      <rect width="100%" height="100%" fill="url(#grid)" />
    </svg>
  );
}

function SplashPreview({ config, playing, onPlayEnd }) {
  const [phase, setPhase] = useState(0);
  const [logoPhase, setLogoPhase] = useState(0);
  const [wordmarkPhase, setWordmarkPhase] = useState(0);
  const [taglinePhase, setTaglinePhase] = useState(0);
  const [exitPhase, setExitPhase] = useState(0);
  const rafRef = useRef(null);
  const startRef = useRef(null);

  const totalMs = config.duration;

  const reset = useCallback(() => {
    setPhase(0);
    setLogoPhase(0);
    setWordmarkPhase(0);
    setTaglinePhase(0);
    setExitPhase(0);
  }, []);

  useEffect(() => {
    if (!playing) { reset(); return; }
    startRef.current = performance.now();

    const tick = (now) => {
      const elapsed = now - startRef.current;
      const t = Math.min(elapsed / totalMs, 1);

      // Logo: 0–50% of duration
      const logoT = Math.min(elapsed / (totalMs * 0.45), 1);
      // Wordmark: 30–70%
      const wordT = Math.max(0, Math.min((elapsed - totalMs * 0.28) / (totalMs * 0.28), 1));
      // Tagline: 55–85%
      const tagT = Math.max(0, Math.min((elapsed - totalMs * 0.5) / (totalMs * 0.25), 1));
      // Exit: 88–100%
      const exitT = Math.max(0, Math.min((elapsed - totalMs * 0.88) / (totalMs * 0.12), 1));

      // Spring easing for logo
      const springEase = (x) => {
        const c4 = (2 * Math.PI) / 3;
        return x === 0 ? 0 : x === 1 ? 1 : Math.pow(2, -10 * x) * Math.sin((x * 10 - 0.75) * c4) + 1;
      };
      const easeOut = (x) => 1 - Math.pow(1 - x, 3);
      const easeOutQuad = (x) => 1 - (1 - x) * (1 - x);

      const easedLogo = config.animStyle === "spring" ? springEase(logoT) :
                        config.animStyle === "bloom" ? easeOut(logoT) :
                        config.animStyle === "instant" ? (logoT > 0.1 ? 1 : logoT * 10) :
                        springEase(logoT);

      setPhase(t);
      setLogoPhase(easedLogo);
      setWordmarkPhase(easeOut(wordT));
      setTaglinePhase(easeOutQuad(tagT));
      setExitPhase(exitT);

      if (t < 1) {
        rafRef.current = requestAnimationFrame(tick);
      } else {
        setTimeout(() => { onPlayEnd && onPlayEnd(); }, 300);
      }
    };

    rafRef.current = requestAnimationFrame(tick);
    return () => { if (rafRef.current) cancelAnimationFrame(rafRef.current); };
  }, [playing, config, totalMs, reset, onPlayEnd]);

  const bgGradient = config.bg[0] === config.bg[1]
    ? config.bg[0]
    : `linear-gradient(145deg, ${config.bg[0]} 0%, ${config.bg[1]} 100%)`;

  const exitOpacity = exitPhase > 0 ? 1 - exitPhase : 1;
  const exitScale = config.exitStyle === "zoom" ? 1 + exitPhase * 0.06 : 1;

  const wordmarkOpacity = wordmarkPhase;
  const wordmarkY = (1 - wordmarkPhase) * 10;
  const taglineOpacity = taglinePhase * 0.55;

  return (
    <div style={{
      width: "100%", height: "100%",
      background: bgGradient,
      borderRadius: "36px",
      position: "relative",
      overflow: "hidden",
      display: "flex",
      flexDirection: "column",
      alignItems: "center",
      justifyContent: "center",
      gap: "0px",
    }}>
      {/* Grid noise for VaultPDF */}
      {config.logoShape === "diamond" && <GridNoise color={config.logoColor} />}

      {/* Ambient glow */}
      <div style={{
        position: "absolute",
        width: "300px",
        height: "300px",
        borderRadius: "50%",
        background: `radial-gradient(circle, ${config.glowColor} 0%, transparent 70%)`,
        top: "50%",
        left: "50%",
        transform: "translate(-50%, -50%)",
        opacity: logoPhase,
        pointerEvents: "none",
      }} />

      {/* Main content */}
      <div style={{
        display: "flex", flexDirection: "column", alignItems: "center", gap: "20px",
        transform: `scale(${exitScale})`,
        opacity: exitOpacity,
        transition: "none",
        position: "relative",
        zIndex: 2,
      }}>
        {/* Logo mark */}
        <LogoMark
          shape={config.logoShape}
          color={config.logoColor}
          glow={config.glowColor}
          letter={config.logoMark}
          animPhase={logoPhase}
          animStyle={config.animStyle}
        />

        {/* Wordmark */}
        <div style={{
          opacity: wordmarkOpacity,
          transform: `translateY(${wordmarkY}px)`,
          transition: "none",
          display: "flex", flexDirection: "column", alignItems: "center", gap: "8px"
        }}>
          <span style={{
            fontFamily: config.font,
            fontSize: "26px",
            fontWeight: "600",
            letterSpacing: "0.1em",
            color: config.textColor,
            lineHeight: 1,
          }}>
            {config.wordmark}
          </span>

          {config.tagline && (
            <span style={{
              fontFamily: config.taglineFont,
              fontSize: "12px",
              fontWeight: "300",
              letterSpacing: "0.06em",
              color: config.textColor,
              opacity: taglineOpacity,
              transition: "none",
            }}>
              {config.tagline}
            </span>
          )}
        </div>
      </div>

      {/* Bottom label */}
      {!playing && (
        <div style={{
          position: "absolute",
          bottom: "20px",
          left: "50%",
          transform: "translateX(-50%)",
          background: "rgba(255,255,255,0.08)",
          backdropFilter: "blur(8px)",
          borderRadius: "20px",
          padding: "6px 16px",
          fontSize: "10px",
          color: "rgba(255,255,255,0.4)",
          letterSpacing: "0.1em",
          fontFamily: "monospace",
          whiteSpace: "nowrap",
        }}>
          PRESS PLAY TO PREVIEW
        </div>
      )}

      {/* Playing indicator */}
      {playing && phase < 1 && (
        <div style={{
          position: "absolute",
          bottom: "20px",
          display: "flex",
          gap: "4px",
          alignItems: "center",
        }}>
          {[0, 1, 2].map(i => (
            <div key={i} style={{
              width: "4px", height: "4px",
              borderRadius: "50%",
              background: config.logoColor,
              opacity: 0.5 + (Math.sin(Date.now() / 200 + i * 1.2) * 0.5),
            }} />
          ))}
        </div>
      )}
    </div>
  );
}

function PhoneFrame({ config, playing, onPlayEnd }) {
  return (
    <div style={{ position: "relative", display: "flex", justifyContent: "center", alignItems: "center" }}>
      {/* Phone shell */}
      <div style={{
        width: "220px",
        height: "440px",
        background: "#1a1a1a",
        borderRadius: "40px",
        padding: "12px",
        boxShadow: "0 40px 80px rgba(0,0,0,0.6), 0 0 0 1px rgba(255,255,255,0.08), inset 0 0 0 1px rgba(255,255,255,0.04)",
        position: "relative",
      }}>
        {/* Dynamic island */}
        <div style={{
          position: "absolute",
          top: "20px",
          left: "50%",
          transform: "translateX(-50%)",
          width: "80px",
          height: "26px",
          background: "#000",
          borderRadius: "13px",
          zIndex: 10,
        }} />

        {/* Screen */}
        <div style={{
          width: "100%",
          height: "100%",
          borderRadius: "30px",
          overflow: "hidden",
          background: "#000",
          position: "relative",
        }}>
          <SplashPreview config={config} playing={playing} onPlayEnd={onPlayEnd} />
        </div>
      </div>

      {/* Side buttons */}
      <div style={{
        position: "absolute",
        right: "-5px",
        top: "80px",
        width: "4px",
        height: "60px",
        background: "#2a2a2a",
        borderRadius: "2px",
      }} />
      <div style={{
        position: "absolute",
        left: "-5px",
        top: "80px",
        width: "4px",
        height: "35px",
        background: "#2a2a2a",
        borderRadius: "2px",
      }} />
      <div style={{
        position: "absolute",
        left: "-5px",
        top: "126px",
        width: "4px",
        height: "35px",
        background: "#2a2a2a",
        borderRadius: "2px",
      }} />
    </div>
  );
}

function MetricBadge({ label, value, color }) {
  return (
    <div style={{
      background: "rgba(255,255,255,0.04)",
      border: "1px solid rgba(255,255,255,0.08)",
      borderRadius: "12px",
      padding: "10px 14px",
      display: "flex",
      flexDirection: "column",
      gap: "2px",
      flex: 1,
      minWidth: "90px",
    }}>
      <span style={{ fontSize: "10px", color: "rgba(255,255,255,0.4)", letterSpacing: "0.1em", fontFamily: "monospace" }}>
        {label}
      </span>
      <span style={{ fontSize: "15px", fontWeight: "600", color: color || "#fff", fontFamily: "monospace" }}>
        {value}
      </span>
    </div>
  );
}

function ConfigTag({ active, color, onClick, children }) {
  return (
    <button onClick={onClick} style={{
      padding: "6px 14px",
      borderRadius: "20px",
      border: active ? `1px solid ${color}` : "1px solid rgba(255,255,255,0.1)",
      background: active ? `${color}18` : "transparent",
      color: active ? color : "rgba(255,255,255,0.4)",
      fontSize: "11px",
      fontWeight: active ? "600" : "400",
      letterSpacing: "0.05em",
      cursor: "pointer",
      transition: "all 0.2s",
      fontFamily: "system-ui, sans-serif",
    }}>
      {children}
    </button>
  );
}

export default function SplashBuilder() {
  const [selected, setSelected] = useState("rite");
  const [playing, setPlaying] = useState(false);
  const [playCount, setPlayCount] = useState(0);
  const config = CONFIGS[selected];

  const play = () => {
    if (playing) return;
    setPlayCount(c => c + 1);
    setPlaying(true);
  };

  const handlePlayEnd = () => {
    setTimeout(() => setPlaying(false), 400);
  };

  // Metrics
  const durationLabel = `${config.duration}ms`;
  const tierLabel = { "millennial-pro": "Millennial Pro", wellness: "Wellness", "power-user": "Power User", "gen-z": "Gen Z" }[config.userTier];
  const exitLabel = EXIT_LABELS[config.exitStyle];
  const animLabel = ANIM_LABELS[config.animStyle].name;

  return (
    <div style={{
      minHeight: "100vh",
      background: "#0A0A0F",
      fontFamily: "system-ui, -apple-system, sans-serif",
      display: "flex",
      flexDirection: "column",
      color: "#fff",
    }}>
      {/* Header */}
      <div style={{
        padding: "24px 28px 0",
        display: "flex",
        alignItems: "flex-start",
        justifyContent: "space-between",
        gap: "16px",
      }}>
        <div>
          <div style={{ fontSize: "10px", color: "rgba(255,255,255,0.3)", letterSpacing: "0.2em", marginBottom: "4px", fontFamily: "monospace" }}>
            RITE LABS / DESIGN SYSTEM
          </div>
          <h1 style={{ fontSize: "22px", fontWeight: "700", margin: 0, lineHeight: 1.1 }}>
            Splash Screen
          </h1>
          <h1 style={{ fontSize: "22px", fontWeight: "700", margin: "0 0 4px", lineHeight: 1.1, color: config.accent }}>
            Studio
          </h1>
          <p style={{ fontSize: "12px", color: "rgba(255,255,255,0.35)", margin: 0 }}>
            Premium. Configurable. Butter-smooth.
          </p>
        </div>

        {/* Play button */}
        <button
          onClick={play}
          disabled={playing}
          style={{
            width: "52px",
            height: "52px",
            borderRadius: "50%",
            background: playing ? "rgba(255,255,255,0.05)" : config.accent,
            border: "none",
            cursor: playing ? "not-allowed" : "pointer",
            display: "flex",
            alignItems: "center",
            justifyContent: "center",
            flexShrink: 0,
            boxShadow: playing ? "none" : `0 0 20px ${config.glowColor}`,
            transition: "all 0.3s",
          }}
        >
          {playing ? (
            <div style={{ width: "16px", height: "16px", border: `2px solid ${config.accent}`, borderTopColor: "transparent", borderRadius: "50%", animation: "spin 0.8s linear infinite" }} />
          ) : (
            <svg width="20" height="20" viewBox="0 0 24 24" fill={playing ? config.accent : "#000"}>
              <polygon points="5,3 19,12 5,21" />
            </svg>
          )}
        </button>
      </div>

      {/* App selector */}
      <div style={{ padding: "20px 28px 0", display: "flex", gap: "8px", flexWrap: "wrap" }}>
        {Object.entries(CONFIGS).map(([key, c]) => (
          <ConfigTag
            key={key}
            active={selected === key}
            color={c.accent}
            onClick={() => { setSelected(key); setPlaying(false); }}
          >
            {c.label}
          </ConfigTag>
        ))}
      </div>

      {/* Main layout */}
      <div style={{
        flex: 1,
        display: "flex",
        flexDirection: "column",
        alignItems: "center",
        padding: "28px 24px",
        gap: "24px",
      }}>
        {/* Phone preview */}
        <PhoneFrame key={`${selected}-${playCount}`} config={config} playing={playing} onPlayEnd={handlePlayEnd} />

        {/* Metrics */}
        <div style={{ width: "100%", maxWidth: "360px", display: "flex", gap: "8px", flexWrap: "wrap" }}>
          <MetricBadge label="DURATION" value={durationLabel} color={config.accent} />
          <MetricBadge label="ANIM" value={animLabel} color={config.accent} />
          <MetricBadge label="EXIT" value={config.exitStyle.toUpperCase()} color="rgba(255,255,255,0.6)" />
          <MetricBadge label="TARGET" value={tierLabel} color="rgba(255,255,255,0.6)" />
        </div>

        {/* Spec card */}
        <div style={{
          width: "100%",
          maxWidth: "360px",
          background: "rgba(255,255,255,0.03)",
          border: "1px solid rgba(255,255,255,0.06)",
          borderRadius: "16px",
          padding: "16px 18px",
          display: "flex",
          flexDirection: "column",
          gap: "10px",
        }}>
          <div style={{ fontSize: "10px", color: "rgba(255,255,255,0.3)", letterSpacing: "0.15em", fontFamily: "monospace" }}>
            DESIGN SPEC — {config.label.toUpperCase()}
          </div>

          {[
            ["Background", config.bg.join(" → ")],
            ["Logo Color", config.logoColor],
            ["Animation", ANIM_LABELS[config.animStyle].desc],
            ["Exit Style", exitLabel],
            ["Wordmark", config.wordmark + (config.tagline ? ` / "${config.tagline}"` : "")],
            ["Typography", config.font.split(",")[0].replace(/'/g, "")],
            ["User Tier", tierLabel],
          ].map(([label, value]) => (
            <div key={label} style={{ display: "flex", justifyContent: "space-between", gap: "8px" }}>
              <span style={{ fontSize: "11px", color: "rgba(255,255,255,0.3)", flexShrink: 0, fontFamily: "monospace" }}>
                {label}
              </span>
              <span style={{ fontSize: "11px", color: "rgba(255,255,255,0.7)", textAlign: "right", fontFamily: "monospace", wordBreak: "break-all" }}>
                {value}
              </span>
            </div>
          ))}
        </div>

        {/* Choreography timeline */}
        <div style={{
          width: "100%",
          maxWidth: "360px",
          background: "rgba(255,255,255,0.03)",
          border: "1px solid rgba(255,255,255,0.06)",
          borderRadius: "16px",
          padding: "16px 18px",
        }}>
          <div style={{ fontSize: "10px", color: "rgba(255,255,255,0.3)", letterSpacing: "0.15em", fontFamily: "monospace", marginBottom: "12px" }}>
            ANIMATION CHOREOGRAPHY
          </div>

          {[
            { label: "Logo Entrance", start: 0, end: 0.45, color: config.accent },
            { label: "Wordmark", start: 0.28, end: 0.56, color: config.logoColor + "99" },
            { label: "Tagline", start: 0.5, end: 0.75, color: "rgba(255,255,255,0.3)" },
            { label: "Pause Beat", start: 0.78, end: 0.88, color: "rgba(255,255,255,0.15)" },
            { label: "Exit", start: 0.88, end: 1, color: "rgba(255,255,255,0.08)" },
          ].map(({ label, start, end, color }) => (
            <div key={label} style={{ display: "flex", alignItems: "center", gap: "10px", marginBottom: "7px" }}>
              <span style={{ width: "72px", fontSize: "9px", color: "rgba(255,255,255,0.35)", fontFamily: "monospace", flexShrink: 0 }}>
                {label}
              </span>
              <div style={{ flex: 1, height: "6px", background: "rgba(255,255,255,0.05)", borderRadius: "3px", position: "relative" }}>
                <div style={{
                  position: "absolute",
                  left: `${start * 100}%`,
                  width: `${(end - start) * 100}%`,
                  height: "100%",
                  background: color,
                  borderRadius: "3px",
                }} />
              </div>
              <span style={{ width: "28px", fontSize: "9px", color: "rgba(255,255,255,0.25)", fontFamily: "monospace", textAlign: "right" }}>
                {Math.round(end * config.duration)}
              </span>
            </div>
          ))}

          <div style={{ display: "flex", justifyContent: "space-between", marginTop: "4px" }}>
            <span style={{ fontSize: "9px", color: "rgba(255,255,255,0.2)", fontFamily: "monospace" }}>0ms</span>
            <span style={{ fontSize: "9px", color: "rgba(255,255,255,0.2)", fontFamily: "monospace" }}>{config.duration}ms</span>
          </div>
        </div>

        {/* Footer note */}
        <div style={{
          width: "100%",
          maxWidth: "360px",
          padding: "12px 16px",
          background: `${config.accent}10`,
          border: `1px solid ${config.accent}30`,
          borderRadius: "12px",
          fontSize: "11px",
          color: "rgba(255,255,255,0.5)",
          lineHeight: 1.5,
        }}>
          <span style={{ color: config.accent, fontWeight: "600" }}>Rite Labs Design System v1.0</span>
          {" "}— Each app occupies a distinct aesthetic quadrant. Hit play to experience the choreography difference between Spring, Bloom, Instant, and Kinetic.
        </div>
      </div>

      <style>{`
        @import url('https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;600&family=DM+Sans:wght@300;400;500&display=swap');
        @keyframes spin { to { transform: rotate(360deg); } }
      `}</style>
    </div>
  );
}
