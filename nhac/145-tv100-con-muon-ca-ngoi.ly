% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Con Muốn Ca Ngợi" }
  composer = "Tv. 100"
  %arranger = "Lm. Kim Long"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  \partial 8 g8 |
  a fs e d |
  g8. g16 c8 b |
  a4 r8 g |
  c4. b8 |
  a8. fs16 g8 a |
  d,4 r8 b' |
  c a d b |
  e,4. g8 |
  a4 a8 fs16 (e) |
  d4. d8 |
  a' a4 fs8 |
  g2 \bar "||" \break
  
  g8 g e16 (g) e8 |
  d4. fs16 (g) |
  a2 |
  c8 c a a16 (c) |
  d2 |
  d8 b16 (a) g8 a16 (g) |
  e4. g16 (a) |
  b4. c8 |
  a8. d16 b8 a |
  g4 r8 \bar "|."
}

nhacPhienKhucAlto = \relative c'' {
  g8 |
  a fs e d |
  g8. e16 a8 g |
  fs4 r8 f! |
  e4. g8 |
  fs8. d16 e8 cs |
  d4 r8 g |
  a g fs g |
  c,4. e8 |
  d4 cs8 [d] |
  b4. b8 |
  c d4 d8 |
  b2
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \set stanza = "ĐK:"
  Con muốn ca ngợi tình thương và đức công minh,
  lạy Chúa, con xin đàn ca kính Ngài.
  Con ước nguyện bước theo đường thẳng ngay,
  tới khi nào Ngài mới đến cùng con.
  <<
    {
      \set stanza = "1."
      Con ăn ở theo lòng thuần khiết
      Ngay trong nhà của con.
      Mắt con chẳng khi nào trông đến
      những việc xấu xa đê tiện.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
	    Con ghê tởm ai làm điều xấu,
	    Không liên hệ cùng con.
	    Những tâm địa gian tà con lánh,
	    những chuyện xấu xa không màng.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Bao nhiêu kẻ đưa điều chùng lén,
	    Con tiêu diệt liền tay,
	    Mắt khi người hay lòng kiêu hãnh,
	    con chẳng tiếp dung khi nào.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
	    Trông ai kẻ nhân hiền trong xứ,
	    Con cho ở gần luôn.
	    Những ai hằng theo đường ngay chính
	    sẽ cộng tác bên con hoài.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Nơi con ở không hề lưu giữ
	    Ai quen trò xảo trá.
	    Quyết xua từ không hề dung dưỡng
	    những kẻ dối gian chuyên nghề.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "6."
	    Quân nham hiểm hung tàn trong xứ
	    Con tiêu diệt mỗi sáng.
	    Quét cho sạch khỏi thành của Chúa
	    những phường tác oai, gây hại.
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
  \key g \major \time 2/4
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
    %\override Staff.TimeSignature.transparent = ##t
    \override Lyrics.LyricSpace.minimum-distance = #0.6
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
