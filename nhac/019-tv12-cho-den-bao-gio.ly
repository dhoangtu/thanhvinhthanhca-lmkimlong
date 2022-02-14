% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Cho Đến Bao Giờ" }
  composer = "Tv. 12"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  \partial 4 \tuplet 3/2 { g8 af g } |
  c4. c8 |
  g4 \tuplet 3/2 { ef8 af g } |
  f4 \tuplet 3/2 { f8 g f } |
  d4. d8 |
  \slashedGrace { f8 ( } g4) \tuplet 3/2 { ef8 g, bf } |
  c4 r8 \bar "||" \break
  
  ef16 ef |
  ef4. d8 |
  c8. ef16 ef8 f |
  g4 \tuplet 3/2 { bf8 c ef } |
  d4. af8 |
  af4 c8 af |
  g2 ~ |
  g4 r8 ef16 ef |
  ef4. d8 |
  c8. ef16 ef8 f |
  g4 \tuplet 3/2 { bf8 c ef } |
  d4. af8 |
  af4 bf8 g |
  c2 ~ |
  c4 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  r4 |
  R2*5
  r4.
  c16 c |
  c4. bf8 |
  c8. c16 c8 d |
  ef4 \tuplet 3/2 { d8 [ef c] } |
  g'4. g8 |
  f4 ef8 c |
  bf2 ~ |
  bf4 r8 c16 c |
  c4. bf8 |
  c8. c16 c8 c |
  ef4 \tuplet 3/2 { d8 [ef c] } |
  g'4. g8 |
  fs4 g8 f! |
  ef2 ~ |
  ef4
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Cho đến bao giờ, lạy Chúa,
      Ngài cứ quên con,
      cho đến bao giờ Ngài vẫn ngoảnh mặt làm ngơ,
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Cho đến bao giờ,
	    hồn những sợ hãi lo toan,
	    cho đến bao giờ lòng vẫn khổ sầu ngày đêm?
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Cho đến bao giờ, Ngài mới nhận tiếng con van
	    cho đến bao giờ cặp mắt sẽ được rạng soi?
    }
  >>
  \set stanza = "ĐK:"
  Nhưng con luôn tin cậy vào tình thương Chúa,
  Lòng con
  <<
  { sướng }
  \new Lyrics {
	  \set associatedVoice = "beBas"
	  \override Lyrics.LyricText.font-shape = #'italic
	  mừng
	}
  >>
  vui trong ơn Chúa cứu độ.
  Xin ca lên muôn lời  phụng mừng danh Chúa
  vì muôn
  <<
  { phúc }
  \new Lyrics {
	  \set associatedVoice = "beBas"
	  \override Lyrics.LyricText.font-shape = #'italic
	  hồng
	}
  >>
  ân cao sang Chúa rộng ban.
}

% Dàn trang
\paper {
  #(set-paper-size "a5")
  top-margin = 3\mm
  bottom-margin = 3\mm
  left-margin = 3\mm
  right-margin = 3\mm
  indent = #0
  #(define fonts
	 (make-pango-font-tree "Deja Vu Serif Condensed"
	 		       "Deja Vu Serif Condensed"
			       "Deja Vu Serif Condensed"
			       (/ 20 20)))
  print-page-number = ##f
  system-system-spacing = #'((basic-distance . 0.1) (padding . 2))
}

TongNhip = {
  \key ef \major \time 2/4
  \set Timing.beamExceptions = #'()
  \set Timing.baseMoment = #(ly:make-moment 1/4)
}

% Đổi kích thước nốt cho bè phụ
notBePhu =
#(define-music-function (font-size music) (number? ly:music?)
   (for-some-music
     (lambda (m)
       (if (music-is-of-type? m 'rhythmic-event)
           (begin
             (set! (ly:music-property m 'tweaks)
                   (cons `(font-size . ,font-size)
                         (ly:music-property m 'tweaks)))
             #t)
           #f))
     music)
   music)

\score {
  \new ChoirStaff <<
    \new Staff \with {
        \consists "Merge_rests_engraver"
        printPartCombineTexts = ##f
      }
      <<
      \new Voice \TongNhip \partCombine 
        \nhacPhienKhucSop
        \notBePhu -1 { \nhacPhienKhucAlto }
      \new NullVoice = beSop \nhacPhienKhucSop
      \new Lyrics \lyricsto beSop \loiPhienKhucSop
      >>
  >>
  \layout {
    \override Lyrics.LyricSpace.minimum-distance = #1.5
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
