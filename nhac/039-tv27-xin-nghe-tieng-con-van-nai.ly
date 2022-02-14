% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Xin Nghe Tiếng Con Van Nài" }
  composer = "Tv. 27"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  \partial 8 f8 |
  f8. g16 f8 d |
  c4. a'8 |
  a8. a16 bf8 bf |
  g2 |
  c8. c16 c8 c |
  c4. bf8 |
  g8. c16 e,8 g |
  f4 \fermata r8 \bar "||" \break
  
  a8 |
  e8. g16 f8 d |
  c4. c16 c |
  c8 a f' d |
  e4 r8 d16 d |
  d8 g g f16 (g) |
  a4. f8 |
  bf8. bf16 a (g) c8 |
  f,4 r8 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  f8 |
  f8. g16 f8 d |
  c4. f8 |
  f8. f16 g8 f |
  e2 |
  a8. a16 a8 a |
  a4. g8 |
  e8. d16 c8 bf |
  a4
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \set stanza = "ĐK:"
  Xin nghe tiếng con van nài,
  Khi con kêu cứu tới Ngài,
  Đây tay con giơ lên
  hướng về thánh điện Chúa liên
  <<
    {
      \set stanza = "1."
      Chúa là chốn con nương nhờ,
      Con kêu lên Ngài chớ làm ngơ,
      Vì Ngài mà im hơi lặng tiếng
      là con như đã xuống mồ.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Chúa đừng bắt con vong mạng
	    theo bao quân tội lỗi tàn hung,
	    miệng ngọt ngào thân thương cầu phúc,
	    lòng những tính toan ác độc.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Chúa nhận tiếng con van nài,
	    nên như khiên mộc giữ gìn con,
	    nguyện một lòng con trông cậy Chúa,
	    và mãi mai xin cám tạ.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Chúa là sức mạnh dân Ngài,
	    là thành trì bền vững chở che,
	    nguyện cầu Ngài thi ân hộ giúp,
	    ngàn kiếp vẫn luôn dắt dìu.
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
    \override Lyrics.LyricSpace.minimum-distance = #1
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
