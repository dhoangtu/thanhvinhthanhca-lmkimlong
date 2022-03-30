% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Hãy Vui Lên" }
  composer = "Is. 65,10-14"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  \partial 8 c16 a |
  a8. bf16 \tuplet 3/2 { a8 g g } |
  g4 r8 f16 f |
  g4 \tuplet 3/2 { g8 a f } |
  c4. a'16 a |
  g8. g16 \tuplet 3/2 { d'8 c b! } |
  c4 r8 c16 a |
  a8. bf16 \tuplet 3/2 { a8 g g } |
  g4 r8 f16 f |
  g4 \tuplet 3/2 { g8 a f } |
  c4. a'16 a |
  g8. c,16 \tuplet 3/2 { g'8 f e } |
  f4 r8 \bar "|." \break
  
  c8 |
  f4. e16 a |
  a4. a16 a |
  f8 bf a16 (g) f8 |
  g4. g16 g |
  e4 \tuplet 3/2 { e8 e e } |
  \slashedGrace { d16 ( } c4) r8 c |
  f4. e16 e |
  a4. a16 a |
  f8 bf a16 (g) f8 |
  g4. g16 f |
  e4 \tuplet 3/2 { c8 a' g } |
  f4 r8 \bar "||"
}

nhacPhienKhucAlto = \relative c' {
  e16 e |
  f8. g16 \tuplet 3/2 { f8 f f } |
  e4 r8 d16 d |
  c4 \tuplet 3/2 { b!8 a b } |
  c4. f16 f |
  e8. e16 \tuplet 3/2 { f8 a g } |
  e4 r8 e16 e |
  f8. g16 \tuplet 3/2 { f8 f f } |
  e4 r8 d16 d |
  c4 \tuplet 3/2 { b!8 a b } |
  c4. f16 f |
  e8. c16 \tuplet 3/2 { bf8 bf c } |
  a4
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \set stanza = "ĐK:"
  Hãy vui lên với Giê -- ru -- sa -- lem,
  cùng thành đô, ta hãy reo mừng,
  hỡi những ai hằng yêu mến thành đô.
  Hãy vui lên với Giê -- ru -- sa -- lem,
  cùng thành đô ta khấp khởi mừng,
  hỡi những ai từng khóc than thành đô.
  <<
    {
      \set stanza = "1."
      Vì đây lời Chúa phán:
      Nay Ta đổ xuống cho thành đô
      phúc thái bình tựa dòng sông cả.
      Và Ta sẽ truyền khiến bao nhiêu nguồn phú vinh mọi dân
      tuôn đổ về tựa thác vỡ bờ.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Rầy ngươi được bú mớm, nâng niu ở gối Ta nào ngơi,
	    Ôm bên lòng dịu dàng ấp ủ,
	    Tựa như một hiền mẫu,
	    Ta luôn trìu mến an ủi ngươi
	    trong nội thành Giê -- ru -- sa -- lem.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Để ngươi thỏa thích nếm vú sữa lộc phúc an ủi ngươi,
	    như con trẻ ngậm bầu sữa mẹ.
	    Nhìn coi lòng mừng rỡ,
	    thân ngươi được sởn sơ nở tươi,
	    như cỏ nội trải thắm nương đồi.
    }
  >>
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
  page-count = #1
}

TongNhip = {
  \key f \major \time 2/4
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
    \override Lyrics.LyricSpace.minimum-distance = #1.2
    \override LyricHyphen.minimum-distance = #0.8
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
