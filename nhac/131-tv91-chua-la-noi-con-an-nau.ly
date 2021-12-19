% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = "Như Cây Dừa Tươi Tốt"
  composer = "Tv. 91"
  %arranger = "Lm. Kim Long"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  \partial 8 c8 |
  e, (f) g4 ~ |
  g8 c, f g |
  a2 |
  e8 e a e |
  d8. c16 a' (bf) a8 |
  g4 f8 f |
  bf4. bf8 |
  bf g c bf16 (c) |
  d4 \slashedGrace { c16 ( } d8) c16 (bf) |
  g4. e16 (d) |
  c8. c16 g'8 g |
  f2 \bar "||" \break
  
  f4. g8 |
  a4. bf8 |
  bf8. bf16 bf8 g |
  bf c r c |
  f,8. a16 a8 bf |
  a g r e |
  f4 g8 f |
  a4. bf8 |
  g (bf) d c |
  c2 ~ |
  c8 a16 _(g) c,8 g' |
  f2 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  r8 |
  R2*12
  f4. e8 |
  f4. g8 |
  g8. g16 g8 e |
  g a r e |
  d8. f16 f8 g |
  f8 c r c |
  d4 c8 a |
  f'4. f8 |
  e (g) bf bf |
  a8. g16 f8 ^(e) |
  f c bf bf |
  a2
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Thú vị thay được tạ ơn Chúa
      Được mừng hát danh Ngài,
      lạy Đấng Tối Cao,
      Từ bình minh tuyên xưng tình thương của Chúa,
      Suốt đêm trường loan truyền lòng Chúa tín trung.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
	    Ngắm kỳ công, lòng con vui sướng
	    Nhìn việc Chúa đã làm mà phải reo lên,
	    Kỳ diệu thay bao nhiêu là tư tưởng Chúa,
	    Quá vĩ đại, công trình Ngài thiết kế nên.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Những kẻ ngu làm sao hay biết
	    Bọn đặc dốt, si dại nào hiểu chi ra,
	    Phường tàn hung khoe tươi tựa cây cỏ đó,
	    Cũng để mà bị diệt trừ vĩnh viễn thôi.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
	    Chúa Cả đây ngàn năm vinh sáng
	    Thù địch Chúa muôn vàn rồi cũng tiêu vong.
	    Nhờ Ngài thương con nay được nên mạnh mẽ,
	    Dám nghênh nhìn quân thù từng lớp rã tan.
    }
  >>
  \set stanza = "ĐK:"
  Người công chính vươn lên như cây dừa tươi tốt,
  lớn mạnh như hương bá Li -- băng
  trồng ở trong nhà Chúa mơn mởn
  giữa khuôn viên thánh điện Chúa ta.
}

loiPhienKhucAlto = \lyrics {
  \repeat unfold 27 { _ }
  \override Lyrics.LyricText.font-shape = #'italic
  giữa khuôn viên
}

% Dàn trang
\paper {
  #(set-paper-size "a5")
  top-margin = 3\mm
  bottom-margin = 3\mm
  left-margin = 5\mm
  right-margin = 5\mm
  indent = #0
  #(define fonts
	 (make-pango-font-tree "Deja Vu Serif Condensed"
	 		       "Deja Vu Serif Condensed"
			       "Deja Vu Serif Condensed"
			       (/ 20 20)))
  print-page-number = ##f
  %system-system-spacing = #'((basic-distance . 0.1) (padding . 1))
  page-count = 1
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
        \notBePhu -3 { \nhacPhienKhucAlto }
      \new NullVoice = beSop \nhacPhienKhucSop
      \new Lyrics \lyricsto beSop \loiPhienKhucSop
      \new NullVoice = beAlto \nhacPhienKhucAlto
      \new Lyrics \lyricsto beAlto \loiPhienKhucAlto
      >>
  >>
  \layout {
    %\override Staff.TimeSignature.transparent = ##t
    \override Lyrics.LyricSpace.minimum-distance = #0.8
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}