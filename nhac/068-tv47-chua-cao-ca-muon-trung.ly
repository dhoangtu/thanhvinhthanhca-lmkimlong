% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Chúa Cao Cả Muôn Trùng" }
  composer = "Tv. 47"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  \partial 4 e8 e |
  d2 ~ |
  d8 c a16 (c) a8 |
  g4 a8 a |
  f4. e8 |
  d a'4 fs8 |
  g2 ~ |
  g4 c8 c |
  a2 ~ |
  a8 a d c |
  b4 a8 a |
  d4. d8 |
  g, e'4 d8 |
  \stemDown c2 ~ |
  c4 \bar "||" \break
  \stemNeutral
  
  c8 c |
  g8. a16 a8 f |
  d4 b8 b |
  b8. b16 g'8 f |
  e4 r8 e16 e |
  f8 e d a' |
  a4. b16 b |
  g8 g16 g d'8 b |
  c4 \bar "|."
}

nhacPhienKhucAlto = \relative c'' {
  c8 c |
  g2 ~ |
  g8 a f16 (a) f8 |
  e4 f8 e |
  d4. c8 |
  b c4 d8 |
  b2 ~ |
  b4 a8 [c] |
  f2 ~ |
  f8 e f fs |
  g4 g8 g |
  fs4. f!8 |
  e g4 g8 |
  <e c>2 ~ |
  <e c>4
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \set stanza = "ĐK:"
  Chúa chúng ta cao cả muôn trùng,
  Tiếng tán tụng vang dậy khắp thành đô.
  Núi thánh Ngài hùng vĩ nguy nga,
  là niềm vui cho toàn cõi địa cầu.
  <<
    {
      \set stanza = "1."
      Chúa trấn ngự giữa các lâu đài,
      Ngài thực là thành quách uy phong
      Khi vua chúa liên hiệp tiến đánh,
      Mới thấy thành là vội vã chạy lui.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Đây chúng con giữa thánh điện Ngài
	    Hồi tưởng lại lòng Chúa yêu thương,
	    Uy phong Chúa vang cùng khắp cõi,
	    Tiếng tán tụng còn rộn rã mọi nơi.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Chốn thánh đô đã thấy tỏ tường
	    Việc kỳ diệu ngày trước nghe qua:
	    Đây tay Chúa muôn vàn kính ái
	    Trấn giữ thành trường tồn mãi ngàn năm.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Hãy ngước trông nhớ mãi trong lòng
	    Nhìn tường tận thành lũy Si -- on,
	    Bao cung tháp, lâu đài đếm kỹ,
	    Nhắc nhớ hoài để hậu thế được hay.
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
  system-system-spacing = #'((basic-distance . 0.1) (padding . 2))
}

TongNhip = {
  \key c \major \time 2/4
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
    \override Lyrics.LyricSpace.minimum-distance = #1
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
